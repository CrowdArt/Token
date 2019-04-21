# Coinbase - Salesforce Org
* [Apex Unit Tests](#apex-unit-tests)
 * [Field History Tracking in Test Methods](#field-history-tracking-in-test-methods)
* [Git](#git)
* [Notes](#notes)
* [OOP](#oop)

## Apex Unit Tests
Unit tests are class methods that verify whether a particular piece of code is working properly. Unit test methods:
  * take no arguments, 
  * commit no data to the database, 
  * send no emails, and 
  * are flagged with the testMethod keyword or 
  * the `@isTest` annotation in the method definition. Also, 
  * test methods must be defined in test classes, that is, classes annotated with `@isTest`.
### Field History Tracking in Test Methods
Field history tracking records (such as AccountHistory) can't be created in test methods because they require other sObject records to be committed first (for example, Account).
### Run Unit Tests
* Some or all methods in a specific class
* Some or all methods in a set of classes
* A predefined suite of classes, known as a test suite
* All unit tests in your org
## Git
Pull requests: A pull request is a package of commits you’re requesting to be merged into the default branch. A pull request provides a place to discuss the changes you’re proposing and invite other team members to comment and complete code reviews. Pull requests also help you see the result of automated tests and many other cool integrations.
*  network commands in Git: `git clone`, `git fetch`, `git pull`, and `git push`.

## Notes
* Application owner object - coinbase inc questionnaire (applying in us)
* Rules engine - sync up with Josh
* Placeholder for Coinbase in or Coinbase UK

## OOP
Every class has three components to it: [1] Attributes, [2] Methods, and [3] Constructors.
1. Attributes - Attributes are the variables that describe your class. Your class’s attributes can be any data type, collection, or even class! Think of attributes to be just like custom fields, except they exist on your class instead of a Salesforce object.  Classes referenced would have to already exist for the class to save!
2. Methods - Methods are the actions available to objects of your class.  You define the logic inside each method, what inputs are required (if any), and what value is returned (if any). Here’s the general template:
```Apex
public ReturnType MethodName(Input1Type, )
```
## Rule Engine
Common uses:
* Custom Object Assignment - lets you assign any record in Salesforce at any time with your own logic. Build custom rules sets to support complex processes.
* User Management - Ideal for organizations with Communities, an automated way to add users to Public and Chatter groups, and allows you to manage the creation of new groups.
* Topic Assignements - With flexible customization, this BREeze capability makes it easy for teams to gain all the advantages offered by Salesforce’s Topics functionality – without writing code.
* Complex Record Assignment - consolidate multiple workflows into a single rules set that’s simple to manage – and doesn’t eat into your workflow rule allocation.
* [SFDCRules – Simple yet powerful Rule Engine for Salesforce](https://www.jitendrazaa.com/blog/salesforce/sfdcrules-simple-yet-powerful-rule-engine-for-salesforce/)

### Sample Architecture
* Rule-Master object
* Rule Criteria - Child object
* Rule Result - Child object.
* To update one record, trigger will call this method and loop through all the rules, rule criteria and update rule result value on the field.
### Onboarding Application
https://onb-coinbase.cs97.force.com/onboarding/s/
#### Pages:
* Check Password
* Create Record
* Error
* Forgot Password
* Home
* HomeDashboard
* Login
* Login Error
* Onboarding Application Form
* Onboarding Application Owners
* Register
* Register Entity Details
* Search
### Controllers
* lightning self reg class and the register entity details class
* onb_ApplicationFormController
* registerEntityDEtails
## Version Control System - VCS
### Source of Truth
* create a package (logical set of code)
* [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.218.0.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
* [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.218.0.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
* [Salesforce Extensions for VS Code](https://developer.salesforce.com/tools/extension_vscode)
* [Getting Started with Scratch Orgs](http://salesforce.vidyard.com/watch/WQzCAyBR8FiJQ8yVXWDwWR)
* [Set Java 8 Platform](http://salesforce.vidyard.com/watch/WQzCAyBR8FiJQ8yVXWDwWR)
* [Harnessing the Power of Salesforce through CLI](http://salesforce.vidyard.com/watch/M3APX9oM72RDUoiqNi8yyg)
* [Understanding the Github Flow](https://guides.github.com/introduction/flow/)

## Links
* [Professional & Minimal WordPress Themes by Alien](https://alienwp.com/)
* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
* http://sfdcmonkey.com/2018/02/25/fetch-multi-picklist-values-lightningduallistbox-component/
* https://www.lightningdesignsystem.com/components/path/
* https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/lightning_overview.htm?search_text=picklist%20field
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/forums/?id=9060G000000I2hzQAC
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/docs/atlas.en-us.uiapi.meta/uiapi/ui_api_resources_picklist_values.html
