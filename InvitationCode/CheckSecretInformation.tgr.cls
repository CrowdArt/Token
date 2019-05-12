trigger CheckSecretInformation on Case (after insert, before update) {
    
    for (Case myCase : Trigger.new) {
        // Step 1: Create a collection containing each of secret keywords
        Set<String> secretKeywords = new Set<String>();
        secretKeywords.add()
    }
}

// child blocks of code have access to variables in their parent blocks of code

// loop through the `secretKeywords` set
