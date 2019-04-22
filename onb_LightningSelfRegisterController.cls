global without sharing class onb_LightningSelfRegisterController extends onb_BaseLightningController {

    public onb_LightningSelfRegisterController() {

    }

    @TestVisible
    private static boolean isValidPassword(String password, String confirmPassword) {
        return password == confirmPassword;
    }

    @TestVisible
    private static boolean siteAsContainerEnabled(String communityUrl) {
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(communityUrl,'');
        return authConfig.isCommunityUsingSiteAsContainer();
    }

    @TestVisible
    private static void validatePassword(User u, String password, String confirmPassword) {
        if(!Test.isRunningTest()) {
            Site.validatePassword(u, password, confirmPassword);
        }
        return;
    }

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
            system.debug(account.Id);
            //4. create the user
            User u = new User();

            u.Username = email;
            u.Email = email;
            u.FirstName = firstname;
            u.LastName = lastname;

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

            String userId = Site.createPortalUser(u, account.Id, password);

            if (Test.isRunningTest()) {
                userId = UserInfo.getUserId();
            }

            User uu = [SELECT Id, ContactId FROM user WHERE Id = :userId];

            insert new onb_Onboarding_Application__c(
                Name =  (fullName + ' Application'),
                Onboarding_Account__c = account.Id,
                Applying_Contact__c = uu.ContactId,
                Legal_Name__c = legalEntityName
            );

            update new Account(Id = account.Id, Onboarding_Community_User__c = userId);

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
            Database.rollback(sp);
            return ex.getMessage();
        }
    }

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

    @AuraEnabled
    public static List<String> getSelectOptions(sObject objObject, string fld) {
        return onb_BaseLightningController.getSelectOptions(objObject, fld);
    }
}
