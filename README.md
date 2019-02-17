# Coinbase

* https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_dynamic_describe_objects_understanding.htm
* http://sfdcmonkey.com/2018/02/25/fetch-multi-picklist-values-lightningduallistbox-component/
* https://www.lightningdesignsystem.com/components/path/
* https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/lightning_overview.htm?search_text=picklist%20field
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/forums/?id=9060G000000I2hzQAC
* http://sfdcmonkey.com/2016/12/05/how-to-fetch-picklist-value-from-sobject-and-set-in-uiinputselect/
* https://developer.salesforce.com/docs/atlas.en-us.uiapi.meta/uiapi/ui_api_resources_picklist_values.htm

##
* [Onboarding 2.0 Community Page](https://josh-coinbase.cs14.force.com/onboarding)
* []()
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
