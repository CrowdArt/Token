global without sharing class onb_LightningSelfRegisterController extends onb_BaseLightningController {

    static final Blob salt = Blob.valueOf(String.valueOf(26462273));
	public static Blob Salt(){
		return salt;
	}

    public onb_LightningSelfRegisterController() {
    }

    /**
     *
     *
     * @param password
     * @param confirmPassword
     *
     * @return
     */
    @TestVisible
    private static boolean isValidPassword(String password, String confirmPassword) {
        return password == confirmPassword;
    }

    /**
     *
     *
     * @param communityUrl
     *
     * @return
     */
    @TestVisible
    private static boolean siteAsContainerEnabled(String communityUrl) {
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(communityUrl,'');
        return authConfig.isCommunityUsingSiteAsContainer();
    }

    /**
     *
     *
     * @param u
     * @param password
     * @param confirmPassword
     */
    @TestVisible
    private static void validatePassword(User u, String password, String confirmPassword) {
        if(!Test.isRunningTest()) {
            Site.validatePassword(u, password, confirmPassword);
        }
        return;
    }


    /**
     *
     *
     * @param firstname
     * @param lastname
     * @param email
     * @param password
     * @param businessEntityType
     * @param confirmPassword
     * @param accountId
     * @param regConfirmUrl
     * @param extraFields
     * @param startUrl
     * @param includePassword
     *
     * @return
     */
    @AuraEnabled
    public static String selfRegister(String firstname ,String lastname, String email, String password, String businessEntityType, String legalEntityName, String confirmPassword, String accountId, String regConfirmUrl, String extraFields, String startUrl, Boolean includePassword) {

        Savepoint sp = null;
        try {
            sp = Database.setSavepoint();

            if (lastname == null || String.isEmpty(lastname)) {
                return Label.Site.lastname_is_required;
            }

            if (email == null || String.isEmpty(email)) {
                return Label.Site.email_is_required;
            }

            if(String.isBlank(legalEntityName)){
                return Label.onbLegalEntityNameRequired;
            }

            //1. initialize vars
            String fullName = firstname + ' ' + lastname;
            String accountName = legalEntityName;
            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName()
                    .get('Institutional_Top_Account').getRecordTypeId();



            //SSCM1-1114 - Check match for existing account with Legal Entity Name
            Id accId = null;
            Boolean accExists = false;
            Blob hashedAccNameDataBlob = crypto.generateMac('HmacSHA256', salt, Blob.valueOf((accountName).tolowerCase()));
            String hashAccountName = EncodingUtil.base64Encode(hashedAccNameDataBlob);
            for(Account acc :[SELECT Id,Name From Account WHERE  HashedAccountName__c=: hashAccountName]){
                accId=acc.Id;
                accExists = true;
                break;

            }
            system.debug('Old Acc:::>> <<< Id >> ' + accId);

            if(accId == null){
                //2. create account
                Account account = new Account(
                        Name = accountName,
                        RecordTypeId = recordTypeId,
                        Email_Address__c = email,
                        OwnerId = onb_Settings__c.getInstance().Account_Owner_Id__c//,
                        //fixme: jk 2/24/19 hardcoding value for new required field business type (added by PL 2/22) --
                        // sync w/team re: surfacing to user during onboarding flow, adding required fields to objects
                        //KR 4/17/19 removing per SSCM1-1953 hotfix
                        //Business_Type__c = 'Other - Business'
                );

                //SSCM1-1526 bypass duplicate checks on self registration accounts
                Database.DMLOptions dml = new Database.DMLOptions();
                dml.DuplicateRuleHeader.AllowSave = true;

                Database.SaveResult sr = Database.insert(account, dml);
                if(!sr.isSuccess()){
                    system.debug(sr.getErrors());
                }
                accId = account.Id;
                system.debug('New Acc:::>>id>> ' + accId);
            }

            //4. create the user
            User u = new User();

            ////SSCM1-1114 - Check match for existing contact with Email
            Id conId = null;
            boolean conExists = false;
            Blob hashedEmaildata = crypto.generateMac('HmacSHA256', salt, Blob.valueOf((email).tolowerCase()));
            String hashEmail = EncodingUtil.base64Encode(hashedEmaildata);
            for(Contact con :[SELECT Email,firstName, lastName From Contact WHERE HashedEmail__c =:hashEmail]){
                conId = con.Id;
                u.Username = con.Email;
                u.Email = con.Email;
                u.FirstName = firstname; //con.firstName;
                u.LastName = lastname;//con.lastName;
                u.ContactId=con.Id;
                u.profileId=([SELECT Description,Id,Name FROM Profile WHERE Name = 'Onboarding']).Id;
                u.alias=firstname.substring(0,2) + lastname.substring(0,1);
                u.timezonesidkey = 'America/Los_Angeles';
                u.localesidkey = 'en_US';
                u.languagelocalekey = 'en_US';
                u.EmailEncodingKey = 'ISO-8859-1';
                conExists=true;
                break;
            }
            system.debug('Old Contact:::>><<< Id >> ' + conId);

            if(accExists && conExists){
                Contact linkConToAcc = new Contact(Id = conId, AccountId=accId);
                update linkConToAcc;

            }
            if(conExists && !accExists){
                Contact linkConToAcc1 = new Contact(Id = conId, AccountId=accId);
                update linkConToAcc1;
                Account linkConToAcc = new Account(Id = accId, Applying_Contact__c=conId);
                update linkConToAcc;

            }

            if(conId == null){
                u.Username = email;
                u.Email = email;
                u.FirstName = firstname;
                u.LastName = lastname;
            }



            String networkId = Network.getNetworkId();

            // If using site to host the community the user should not hit s1 after logging in from mobile.
            if(networkId != null && siteAsContainerEnabled(Network.getLoginUrl(networkId))) {
                u.put('UserPreferencesHideS1BrowserUI',true);
            }


            String nickname = ((firstname != null && firstname.length() > 0) ? firstname.substring(0,1) : '' ) + lastname.substring(0,1);
            nickname += String.valueOf(Crypto.getRandomInteger()).substring(1,7);
            u.put('CommunityNickname', nickname);

            if (extraFields != null) {
                List<Object> extraFieldsList = (List<Object>) JSON.deserializeUntyped(extraFields);
                for (Object thisFieldObject : extraFieldsList) {
                    Map<String,Object> thisField = (Map<String,Object>) thisFieldObject;
                    Schema.SObjectField sof = Schema.SObjectType.User.fields.getMap().get((String) thisField.get('fieldPath'));
                    u.put(sof, thisField.get('value'));
                }
            }

            if (includePassword) {
                if (!isValidPassword(password, confirmPassword)) {
                    return Label.site.passwords_dont_match;
                }
                validatePassword(u, password, confirmPassword);
            }
            else {
                password = null;
            }

            password = generateRandomString(12);
            String userId = null;
            //If contact exists, we create user and contact through Site.createPortalUser
            if(conExists){
                insert u;
                System.setPassword(u.Id, password);
                userId = u.Id;
            }


            //SSCM1-1114 : if no existing contact
            if(conId == null){ // && accId == null
                userId = Site.createPortalUser(u, accId, password);
            }


            if (Test.isRunningTest()) {
                userId = UserInfo.getUserId();
            }
            User uu = [SELECT Id, ContactId FROM user WHERE Id = :userId];
            insert new onb_Onboarding_Application__c(
                    Name =  (fullName + ' Application'),
                    Onboarding_Account__c = accId,
                    Applying_Contact__c = uu.ContactId,
                    Legal_Name__c = legalEntityName
            );

            update new Account(Id = accId, Onboarding_Community_User__c = userId);

            if (userId != null) {

                if (includePassword && password != null && password.length() > 1) {
                    PageReference lgn = Site.login(email, password, startUrl);

                    if(!Test.isRunningTest()) {
                        aura.redirect(lgn);
                    }

                } else {
                    PageReference lgn = Site.login(email, password, '/s/RegisterEntityDetails?b=' + businessEntityType);
                    if(!Test.isRunningTest()) {
                        aura.redirect(lgn);
                    }

                }
            }
            return null;
        }
        catch (Exception ex) {
            system.debug('Sumit exception> ' + ex.getMessage() + '<>' + ex.getLineNumber());
            Database.rollback(sp);
            return ex.getMessage();
        }
    }


    /**
     *
     *
     * @param extraFieldsFieldSet
     *
     * @return
     */
    @AuraEnabled
    public static List<Map<String,Object>> getExtraFields(String extraFieldsFieldSet) {
        List<Schema.FieldSetMember> fieldsetFields = new List<Schema.FieldSetMember>();
        if(Test.isRunningTest()) {
            //KR 4/16/2019 SSCM1-1953 Test coverage throws error using TEST_FIELDSET_MEMBER when accessing
            //FieldSetMember methods.
            //fieldsetFields.add(TEST_FIELDSET_MEMBER);
        }
        else {
            Schema.FieldSet fieldSet = Schema.SObjectType.User.fieldSets.getMap().get(extraFieldsFieldSet);
            fieldsetFields = fieldSet == null ? fieldsetFields : fieldSet.getFields();
        }
        List<Map<String,Object>> extraFields = new List<Map<String,Object>>();
        for (Schema.FieldSetMember f : fieldsetFields) {
            Map<String, Object> fieldDetail = new Map<String, Object>();
            fieldDetail.put('dbRequired', f.getDBRequired());
            fieldDetail.put('fieldPath', f.getFieldPath());
            fieldDetail.put('label', f.getLabel());
            fieldDetail.put('required', f.getRequired());
            fieldDetail.put('type', f.getType());
            fieldDetail.put('value', '');   // client will populate
            extraFields.add(fieldDetail);
        }
        return extraFields;
    }

    @TestVisible
    private static Schema.FieldSetMember TEST_FIELDSET_MEMBER;

    /**
     *
     *
     * @param expId
     *
     * @return
     */
    @AuraEnabled
    global static String setExperienceId(String expId) {
        // Return null if there is no error, else it will return the error message
        try {
            if (expId != null) {
                Site.setExperienceId(expId);
            }
            return null;
        } catch (Exception ex) {
            return ex.getMessage();
        }
    }

    /**
     *
     *
     * @param objObject
     * @param fld
     *
     * @return
     */
    @AuraEnabled
    public static List<String> getSelectOptions(sObject objObject, string fld) {
        return onb_BaseLightningController.getSelectOptions(objObject, fld);
    }
}
