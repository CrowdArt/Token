## Using Maps
Common use case: `Map<ID, SObject>`

#### Get a list of contacts
```apex
List<Contact> contacts = [SELECT ID, Name FROM Contact LIMIT 50];
```
#### Map constructor will automatically key each contact by its ID
```apex
Map<ID, Contact> contactMap = new Map<ID, Contact>(contacts);
```

#### Or combine two lines above into one line - this is a very common design pattern
```apex
Map<ID, Contact> contactMape = new Map<ID, Contact>([SELECT ID, Name FROM Contact limit  50]);
```
