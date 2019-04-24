@isTest
private class onb_RegisterEntityDetailsControllerTest {
    
    @testSetup
    static void setupData(){
        onb_Settings__c setting = new onb_Settings__c(Account_Owner_Id__c = UserInfo.getUserId());
        insert setting;
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
    static void testValidatePassword() {
        onb_LightningSelfRegisterController.validatePassword(new User(),'password?@12334', 'password?@12334');
        //System.assertEquals(expected, actual);
    }
    
    @IsTest
    static void testCompleteRegistration() {
        Id userId = UserInfo.getUserId();
    }

}
