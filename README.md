# Salesforce Org
### Table of Contents
* [Apex Code Analysis Tool](#apex-code-analysis-tool)
* [Apex String Class](#apex-string-class)
* [Apex System Class](#apex-system-class)
* [Apex Unit Tests](#apex-unit-tests)
   * [Field History Tracking in Test Methods](#field-history-tracking-in-test-methods)
   * [LightningSelfRegisterController](#lightningselfregistercontroller)
   * [Run Unit Tests](#run-unit-tests)
* [Aura](#aura)
   * [Validating Fields](#validating-fields)
* [Courses](#courses)
* [Git](#git)
* [JavaScript](#javascript)
* [Links](#links)
* [Notes](#notes)
* [Onboarding Application](#onboarding-application)
* [OOP](#oop)
* [Salesforce Community](#salesforce-community)
#
## Apex Code Analysis Tool
* [Gearset](https://gearset.com/)
* [Toolkit for Salesforce](https://cloudtoolkit.co/)
* [Salesforce Schema Lister](https://schemalister.herokuapp.com/schema/65939236-c64f-4c7f-8152-5b15120a1fea/)
* [Scan Results](https://sfcodeclean.herokuapp.com/job/757c9186-09dd-40f6-b679-174dc6a355d5/)
* [Spring Cleaning Apex Code with the Tooling API](https://andyinthecloud.com/2013/02/02/spring-cleaning-apex-code-with-the-tooling-api/)
## Apex String Class
* [String Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_string.htm)
## Apex System Class
* [System Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_system.htm)

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
# Aura
## Validating Fields
* [Validating Fields](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/js_validate_fields.htm)
### LightningSelfRegisterController
* LightningSelfRegisterControllerTest.testSelfRegisterWithCreatedAccount
* LightningSelfRegisterControllerTest.testGetNonEmptyExtraFields
* LightningSelfRegisterControllerTest.testGetNullExtraFields
* LightningSelfRegisterControllerTest.testSelfRegisterWithProperCredentials
* LightningSelfRegisterControllerTest.testSiteAsContainerEnabled
* LightningSelfRegisterControllerTest.testSelfRegisterWithCreatedAccount
* LightningSelfRegisterControllerTest.testSelfRegistration
* LightningSelfRegisterControllerTest.testGetExtraFieldsInSelfRegistration
* LightningSelfRegisterControllerTest.testIsValidPassword

## Git
Pull requests: A pull request is a package of commits you’re requesting to be merged into the default branch. A pull request provides a place to discuss the changes you’re proposing and invite other team members to comment and complete code reviews. Pull requests also help you see the result of automated tests and many other cool integrations.
*  network commands in Git: `git clone`, `git fetch`, `git pull`, and `git push`.

## JavaScript
* [document.getElementById() method](https://www.javatpoint.com/document-getElementById()-method)
## Notes
* Application owner object - coinbase inc questionnaire (applying in us)
* Rules engine - sync up with Josh
* Placeholder for Coinbase in or Coinbase UK

## OOP
Every class has three components to it: [1] Attributes, [2] Methods, and [3] Constructors.
1. Attributes - Attributes are the variables that describe your class. Your class’s attributes can be any data type, collection, or even class! Think of attributes to be just like custom fields, except they exist on your class instead of a Salesforce object.  Classes referenced would have to already exist for the class to save!
2. Methods - Methods are the actions available to objects of your class.  You define the logic inside each method, what inputs are required (if any), and what value is returned (if any). Here’s the general template:
```Apex
public ReturnType MethodName(Input1Type Input1Variable) {
  // Method logic goes here
}
```
* `ReturnType` is the data type, collection, or class that’s returned when your method is called. 
* If you don’t want your method to return anything, use `void`.
* `MethodName` is whatever you want to name your method
* `Input1Type` is the data type, collection, or class that represents your first accepted input, and `Input1Variable` is the variable name you’re assigning it to so you can reference it in your method’s logic. You can add more inputs to your method by separating them with commas. 
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

## Onboarding Application
### Login
https://onb-coinbase.cs97.force.com/onboarding/s/
### Self-Register
https://onb-coinbase.cs97.force.com/onboarding/s/login/SelfRegister
### Register Entity Details
https://onb-coinbase.cs97.force.com/onboarding/s/RegisterEntityDetails?b=null

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

## Salesforce Community
* [Lightning Communities Developer Guide Version 44.0 Winter ’19](chrome-extension://oemmndcbldboiebfnladdacbdfmadadm/https://resources.docs.salesforce.com/216/latest/en-us/sfdc/pdf/communities_dev.pdf)
* [Set Up Self-Registration for Your Community](https://help.salesforce.com/articleView?id=networks_customize_selfreg_page.htm&type=5)
* [Set Up and Manage Salesforce Communities Winter ’19](chrome-extension://oemmndcbldboiebfnladdacbdfmadadm/https://resources.docs.salesforce.com/216/latest/en-us/sfdc/pdf/communities.pdf)

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
* [Class Pattern in Java](https://docs.oracle.com/javase/1.5.0/docs/api/index.html?java/util/regex/Pattern.html)
* [Introduction to the “static” keyword](http://www.sfdc99.com/2015/01/22/introduction-to-the-static-keyword/)
* [Stackoverflow - Coupon code validation in js](https://stackoverflow.com/questions/38865345/coupon-code-validation-funcanality-using-javascript-or-jquery)
* [Pattern and Matcher Example](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_classes_pattern_and_matcher_example.htm)
* [SSH - GitHib Help](https://help.github.com/en/articles/about-ssh)
* [Salesforce Developer Centers](https://developer.salesforce.com/developer-centers/)
* [Professional & Minimal WordPress Themes by Alien](https://alienwp.com/)
* [Unix Cheatsheet](http://www.mathcs.emory.edu/~valerie/courses/fall10/155/resources/unix_cheatsheet.html)
* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
* http://sfdcmonkey.com/2018/02/25/fetch-multi-picklist-values-lightningduallistbox-component/
* https://www.lightningdesignsystem.com/components/path/
* https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/lightning_overview.htm?search_text=picklist%20field
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/forums/?id=9060G000000I2hzQAC
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/docs/atlas.en-us.uiapi.meta/uiapi/ui_api_resources_picklist_values.html
## Courses
* [JavaScript in Salesforce - Dan Appleman](https://app.pluralsight.com/player?name=javascript-in-salesforce-getting-started-m1&mode=live&clip=5&course=javascript-in-salesforce-getting-started&author=dan-appleman)
* [Force.com and Apex for Developers by Dan Appleman - Pluralsight]()
