# Coinbase

### Notes
* Application owner object - coinbase inc questionnaire (applying in us)
* Rules engine - sync up with Josh
* Placeholder for Coinbase in or Coinbase UK

## Rule Engine
Common uses:
* Custom Object Assignment - lets you assign any record in Salesforce at any time with your own logic. Build custom rules sets to support complex processes.
* User Management - Ideal for organizations with Communities, an automated way to add users to Public and Chatter groups, and allows you to manage the creation of new groups.
* Topic Assignements - With flexible customization, this BREeze capability makes it easy for teams to gain all the advantages offered by Salesforce’s Topics functionality – without writing code.
* Complex Record Assignment - consolidate multiple workflows into a single rules set that’s simple to manage – and doesn’t eat into your workflow rule allocation.

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
* 

## Links
* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
* http://sfdcmonkey.com/2018/02/25/fetch-multi-picklist-values-lightningduallistbox-component/
* https://www.lightningdesignsystem.com/components/path/
* https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/lightning_overview.htm?search_text=picklist%20field
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/forums/?id=9060G000000I2hzQAC
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/docs/atlas.en-us.uiapi.meta/uiapi/ui_api_resources_picklist_values.htm
