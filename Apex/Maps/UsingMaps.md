## Using Maps
Common use case: `Map<ID, SObject>`

#### Get a list of contacts
```apex
List<Contact> contacts = [SELECT ID, Name FROM Contact LIMIT 50];
```

