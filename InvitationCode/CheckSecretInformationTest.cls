@isTest
private class CheckSecretInformationTest {
    
    @isTest static void createCaseWithSecretInfo() {
        // create a case with all of the requirements
        Case myCase         = mew Case();
        myCase.Subject      = 'Help';
        myCase.Description  = 'Test';
        insert myCase;
        System.debug('Case ' + myCase.Id + ' created with description ' + myCase.Description);
    }
}
