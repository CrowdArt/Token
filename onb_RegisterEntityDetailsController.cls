global with sharing class onb_RegisterEntityDetailsController extends onb_BaseLightningController {

    public onb_RegisterEntityDetailsController(){

    }

    @AuraEnabled
    public static Id getCurrentUserId() {
        return UserInfo.getUserId();
    }

    @AuraEnabled
    public static List<String> getSelectOptions(sObject objObject, String fld) {
        return onb_BaseLightningController.getSelectOptions(objObject, fld);
    }

    @AuraEnabled
    public static List<Product2> getProducts(){
        List<Product2> products = [Select Id, Name from Product2];
        return products;
    }

    @AuraEnabled
    public static List<String> getCountriesWithStates(){
        List<Schema.PicklistEntry> activeEntries = new List<Schema.PicklistEntry>();
        for (Schema.PicklistEntry pe : onb_Onboarding_Application__c.State_Province__c.getDescribe().getPicklistValues()) {
            if (pe.isActive()) {
                activeEntries.add(pe);
            }
        }
        List<Object> untyped = (List<Object>)JSON.deserializeUntyped(JSON.serialize(activeEntries));
        List<Schema.PicklistEntry> controlEntries = onb_Onboarding_Application__c.Business_Address_Country__c.getDescribe().getPicklistValues();
        Set<String> result = new Set<String>();
        for (Object untypedEntry : untyped) {
            Map<String,Object> entry = (Map<String,Object>)untypedEntry;
            BitsetChecker checker = new BitsetChecker((String)entry.get('validFor'));
            Integer index = -1;
            for (Schema.PicklistEntry cpe : controlEntries) {
                index++;
                if (!cpe.isActive()) continue;
                if (checker.testBit(index)) {
                    result.add(cpe.getValue());
                }
            }
        }
        return new List<String>(result);
    }

    public class BitsetChecker {
        public String validFor {get;private set;}
        public String vfDecoded {get;private set;}
        public String[] hexBytes {get;private set;}
        public Integer[] bytes {get;private set;}

        public BitsetChecker(String validFor) {
            this.validFor = validFor;
            this.vfDecoded = null;
            hexBytes = new String[] {};
            bytes = new Integer[] {};
            if (String.isNotBlank(validFor)) {
                this.vfDecoded = String.isNotBlank(validFor) ?
                    EncodingUtil.convertToHex(EncodingUtil.base64Decode(validFor)).toLowerCase() : '';
                if (String.isNotBlank(vfDecoded) && Math.mod(vfDecoded.length(), 2) == 0) {
                    for (Integer i = 0; i < vfDecoded.length(); i += 2) {
                        String hexByte = vfDecoded.substring(i, i + 2);
                        hexBytes.add(hexByte);
                        bytes.add(hexToDecimal(hexByte).intValue());
                    }
                }
            }
        }

        public Boolean testBit(Integer n) {
            Boolean result = false;
            if (n != null && n < size() && hexBytes != null) {
                Integer bytesPos = n >> 3;
                Integer targetByte = bytesPos < bytes.size() ? bytes[bytesPos] : null;
                if (targetByte != null) {
                    Integer mask = 128 >> Math.mod(n, 8);
                    Integer maskedByte = targetByte & mask;
                    result = maskedByte != 0;
                }
            }
            return result;
        }

        public Integer size() {
            return bytes.size() * 8;
        }

        public Decimal hexToDecimal(String sourceHex) {
            String hex = '0123456789abcdef';
            String[] hexValue = sourceHex.split('');
            Decimal result = 0;
            for(Integer index = 0; index < hexValue.size(); index++) {
                result = (result * 16) + hex.indexOf(hexValue[index]);
            }
            return result;
        }
    }

    @TestVisible
    private static Id TEST_ACCOUNT_ID;

    @AuraEnabled
    public static String completeRegistration(Id appId, String street1, String street2, String  city, String country, String state, String postalCode, String[] products, String businessType, String coinbaseEntity, String legal, String legalEntityType, String otherBusinessType) {
        Savepoint sp = null;

        try{

            sp = Database.setSavepoint();

            Id userId = UserInfo.getUserId();
            User user = [SELECT Id, Contact.AccountId FROM User WHERE Id = :UserInfo.getUserId()];
            Id onboarding_account_id = Test.isRunningTest() ? TEST_ACCOUNT_ID : user.Contact.AccountId;
            onb_Onboarding_Application__c app = [
                SELECT Id, Business_Address_Line_1__c, Business_Address_Line_2__c, Business_Address_Country__c,
                    State_Province__c, Business_Address_Postal_Code__c
                FROM onb_Onboarding_Application__c
                WHERE Onboarding_Account__c = :onboarding_account_id
                LIMIT 1
            ];

            app.Business_Address_Line_1__c = street1;
            app.Business_Address_Line_2__c = street2;
            app.Business_Address_Country__c = country;
            app.State_Province__c = state;
            app.Business_Address_Postal_Code__c = postalCode;
            app.Industry_of_applying_entity__c = legal;
            app.Business_Type__c = businessType;
            app.Coinbase_Entity__c = coinbaseEntity;
            app.Legal_Entity_Type__c = legalEntityType;
            app.Other_Business_Type__c = otherBusinessType;

            update app;

            List<onb_Onboarding_Application_Product__c> obProducts = new List<onb_Onboarding_Application_Product__c>();

            for (String product : products) {
                product = EncodingUtil.urlDecode(product, 'ASCII');
                List<String> pTokens = product.split('::');

                obProducts.add(new onb_Onboarding_Application_Product__c(
                    Onboarding_Application__c = app.Id,
                    Product__c = Id.valueOf(pTokens[0]),
                    Name = pTokens[1]
                ));

            }

            insert obProducts;

            Site.forgotPassword(UserInfo.getUserName(), 'Onboarding_Community_Welcome_Email');

            PageReference regCompleteRef = new PageReference('./login/CheckPasswordResetEmail');

            if (!Test.isRunningTest()) {
                aura.redirect(regCompleteRef);
            }

        } catch (Exception ex) {

            Database.rollback(sp);
            System.debug(ex);
            return ex.getMessage();
        }


        return null;
    }
}
