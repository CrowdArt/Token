trigger CheckSecretInformation on Case (after insert, before update) {
    
    // Step 1: Create a collection containing each of secret keywords
        Set<String> secretKeywords = new Set<String>();
        secretKeywords.add('Credit Card');
    
    // Step 2: Check to see if our case contains any of the secret keywords
    List<Case> caseWithSecretInfo = new List<Case>();
    for (Case myCase : Trigger.new) {
        for (String keyword : secretKeywords) {
            // check if the case description uses a specific keyword
            if (myCase.Description != null && myCase.Description.contains(keyword)) {
                caseWithSecretInfo.add(myCase);
                System.debug('Case ' + myCase.Id + ' include secret keyword ' + keyowrd);
                break;
            }    
        }
        
    }
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
