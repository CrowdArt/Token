@isTest
private class onb_RegisterEntityDetailsControllerTest {
    @testSetup
    static void setupData(){
        onb_Settings__c setting = new onb_Settings__c(Account_Owner_Id__c = UserInfo.getUserId());
        insert setting;
    }
    
    @isTest 
    static void testCurrentUserId() {
        Id cui = onb_RegisterEntityDetailsController.getCurrentUserId();
        System.assertEquals('3', cui);
    }
    
    @isTest
    static void test_CompleteRegistration() {
        onb_CommunityHelper helper = new onb_CommunityHelper();
        helper.setup();

        Test.startTest();
        onb_RegisterEntityDetailsController.TEST_ACCOUNT_ID = helper.account.Id;

        onb_RegisterEntityDetailsController redc = new onb_RegisterEntityDetailsController();
        onb_RegisterEntityDetailsController.getCurrentUserId();
        onb_RegisterEntityDetailsController.getSelectOptions(new Opportunity(), 'StageName');
        onb_RegisterEntityDetailsController.getCountriesWithStates();

        List<Product2> testProducts = onb_RegisterEntityDetailsController.getProducts();
        System.assert(testProducts.size() > 0);      
    }
    
    @IsTest
    static void test3() {
        // Access public method
        onb_RegisterEntityDetailsController redc = new onb_RegisterEntityDetailsController();
    }
    
    @IsTest
    static void testTestAccountId() {
        
    }
    
    @IsTest
    static void testValidatePassword() {
        onb_LightningSelfRegisterController.validatePassword(new User(),'password?@12334', 'password?@12334');
		//System.assertEquals(expected, actual);
    }
    
    @IsTest
    static void testCompleteRegistration() {
        Account acc = new Account(name = 'test acc');
        insert acc;
        List < Account > accounts = [SELECT Id FROM Account LIMIT 1];
        System.assert(!accounts.isEmpty(), 'There must be at least one account in this environment!');
        String accountId = accounts[0].Id;
        Map < String, String > paramsMap = initializeParams();
        System.assertEquals(null, onb_RegisterEntityDetailsController.completeRegistration(null, paramsMap.get('street1'), paramsMap.get('street2'), paramsMap.get('city'), paramsMap.get('country'), paramsMap.get('state'), paramsMap.get('postalCode'), 
        						null, paramsMap.get('businessType'), paramsMap.get('coinbaseEntity'), paramsMap.get('legal'), paramsMap.get('legalEntityType'), paramsMap.get('otherBusinessType')));
        System.assertEquals('8', onb_RegisterEntityDetailsController.completeRegistration(null, paramsMap.get('street1'), paramsMap.get('street2'), paramsMap.get('city'), paramsMap.get('country'), paramsMap.get('state'), paramsMap.get('postalCode'), 
        						null, paramsMap.get('businessType'), paramsMap.get('coinbaseEntity'), paramsMap.get('legal'), paramsMap.get('legalEntityType'), paramsMap.get('otherBusinessType')));
    }
    
    @IsTest
    static void testSOQL() {
        onb_Onboarding_Application__c onbApp = new onb_Onboarding_Application__c(Name = 'VukTest');
        insert onbApp;
        List <onb_Onboarding_Application__c> onb = [SELECT Id FROM onb_Onboarding_Application__c];
        System.assert(!onb.isEmpty(), 'Add app');
        String onbAppId = onb[0].Id;
        Map<String, String> paramsMap = initializeParams();
    }
    
    //Helper method to initialize the parameters required for SelfRegistration.
    private static Map <String, String> initializeParams() {
        Map <String, String> paramsMap = new Map <String, String>();
        String street1 = '1 Front Street';
        String street2 = '28';
        String city = 'San Francisco';
        String state = 'CA';
        String postalCode = '94108';
        String businessType = '';
        String coinbaseEntity = '';
        String legal = '';
        String legalEntityType = '';
        String otherBusinessType = '';
        paramsMap.put('street1', street1);
        paramsMap.put('street2', street2);
        paramsMap.put('city', city);
        paramsMap.put('state', state);
        paramsMap.put('postalCode', postalCode);
        paramsMap.put('businessType', businessType);
        paramsMap.put('coinbaseEntity', coinbaseEntity);
        paramsMap.put('legal', legal);
        paramsMap.put('legalEntityType', legalEntityType);
        paramsMap.put('otherBusinessType', otherBusinessType);
        return paramsMap;
}
