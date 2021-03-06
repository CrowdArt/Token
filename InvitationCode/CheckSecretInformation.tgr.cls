trigger CheckSecretInformation on Case (after insert, before update) {
    
    String childCaseSubject = 'Warning: Parent case may contain secret info.';
    
    // Step 1: Create a collection containing each of secret keywords
    Set<String> secretKeywords = new Set<String>();
    secretKeywords.add('Credit Card');
    
    // Step 2: Check to see if our case contains any of the secret keywords
    List<Case> caseWithSecretInfo = new List<Case>();
    for (Case myCase : Trigger.new) {
        if (myCase.Subject != childCaseSubject) {
            for (String keyword : secretKeywords) {
                // check if the case description uses a specific keyword
                if (myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
                    caseWithSecretInfo.add(myCase);
                    System.debug('Case ' + myCase.Id + ' include secret keyword ' + keyowrd);
                    break;
                }    
            }
        }
    }
    
    // Step 3: If our case contains a secret keyword, create a child case
    List<Case> casesToCreate = new List<Case>();
    for (Case caseWithSecretInfo : casesWithSecretInfo) {
        Case childCase = new Case();
        childCase.subject = childCaseSubject;
        childCase.ParentId = caseWithSecretInfo.Id;
        childCase.isEscalated = true;
        childCase.isPriority = 'High';
        childCase.Description = 'At least one of the following keywords were found ' + secretKeywords;
        casesToCreate.add(childCase);
    }
    insert childCase;
}

// child blocks of code have access to variables in their parent blocks of code

// loop through the `secretKeywords` set, 
// and for each value in that set,
// temporarily assign it to a string variable called keyword for the duration of the iteration.

// check if the case description uses a specific keyword
// if the case description contains the secret keyword we need to create a child case.
// one block of code should do one thing
// generally SObjects work better in Lists

// if our case contains the secret keyword add it to the List<Case>

/**
* Test class requirements:
* 1. Create or update a case
* 2. Case subject cannot begin with warning
* 3. Case description cannot be null
* 4. Case description contains a secret keyword
*/

