/**
This test utility class contains one static method, createAccountsWithOpps(), which accepts the number of accounts 
(held in the numAccts parameter) and the number of related opportunities 
to create for each account (held in the numOppsPerAcct parameter). 
The first loop in the method creates the specified number of accounts and stores them in the accts list variable. 
After the first loop, the insert() DML statement is called to create all accounts in the list in the database.

The second loop creates the opportunities. Because each group of opportunities are linked to one account, 
the outer loop iterates through accounts and contains a nested loop that creates related opportunities for the current 
account. The next time the nested loop is run, opportunities are added to the same list using the add() method. 
Opportunities are linked to their parent accounts using the AccountId field. The total number of all opportunities that 
are created is the product of the number of opportunities with the number of accounts (numOppsPerAcct*numAccts). 
Next, the insert() DML statement is efficiently called outside the loop to create all opportunities in the collection for 
all accounts in one call only.

Finally, this method returns a list of the new accounts.
*/
@isTest
public class TestDataFactory {
    public static List<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        List<Account> accts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,
                                       StageName='Prospecting',
                                       CloseDate=System.today().addMonths(1),
                                       AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        
        return accts;
    }
}
