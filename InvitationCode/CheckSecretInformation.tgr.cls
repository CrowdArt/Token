trigger CheckSecretInformation on Case (after insert, before update) {
    
    // Step 1: Create a collection containing each of secret keywords
        Set<String> secretKeywords = new Set<String>();
        secretKeywords.add('Credit Card');
    
    for (Case myCase : Trigger.new) {
        // Step: Check to see if our case contains any of the secret keywords
        for (String keyword : secretKeywords) {
            // check if the case description uses a specific keyword
            if (myCase.Description.contains(keyword)) {}    
        }
        
    }
}

// child blocks of code have access to variables in their parent blocks of code

// loop through the `secretKeywords` set, 
// and for each value in that set,
// temporarily assign it to a string variable called keyword for the duration of the iteration.

// check if the case description uses a specific keyword
// if the case description contains the secret keyword we need to create a child case.
