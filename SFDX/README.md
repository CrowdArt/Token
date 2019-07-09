# Salesforce DX and Git
## Dev Guides
* [Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
* [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
* [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)

## Commands
* `sfdx force:org:list --verbose`
* sfdx force:apex:trigger:create -n mytrigger -s Account -e 'before insert, after upsert' -d <app-dir>/main/default/triggers
* sfdx force:mdapi:deploy -c --help
* sfdx force:mdapi:deploy:report vuk.djukic_external.k2@coinbase.com.onb --help
* vukdjukic::~/Documents/sfdx/staging->
* ld
* sfdx force:org:list
* sfdx force:source:retrieve -u staging -x ./package.xml
* sfdx force:org:list --all
* sfdx force:alias:set --help
* sfdx force:source:retrieve -u partial -x ./package.xml
* sfdx force:org:login
* sfdx force:project:create -n partial
* git diff salesforce/src/classes/onb_ApplicationFormControllerTest.cls
* git diff
* sfdx force:apex:test:report -i 707c000002S8rFm -u vuk.djukic_external.k2@coinbase.com.staging
* sfdx force:apex:test:run -u vuk.djukic_external.k2@coinbase.com.staging --testlevel=RunLocalTests
* sfdx force:auth:web:login -r https://test.salesforce.com
* code . src/onb_ApplicationFormControllerTest
* sfdx force:apex:test:run -u vuk.djukic_external.k2@coinbase.com.onb2.onbvuk2 --testlevel=RunLocalTests
* sfdx force:mdapi:deploy -d src/ -u staging --testLevel=RunLocalTests
* sfdx force:apex:test:run --help
* sfdx force:config:list
* sfdx force:apex:test:run --resultformat human vuk.djukic_external.k2@coinbase.com.onb2.onbvuk2
* sfdx force:auth:web:login --setalias my-sandbox
#
* `sfdx force:lightning:component:create -n myFirstWebComponent -d force-app/main/default/lwc --type lwc`
  * `-n` — This defines the name of the Lightning web component folder and its files
  * `-d` — This defines the target directory where the Lightning web component should be created. The target directory must be named lwc
  * `--type` — This specifies that you want to create a Lightning Web Component
#

### Create a scratch org with the alias GeoAppScratch:
* `sfdx force:org:create -s -f config/project-scratch-def.json -a GeoAppScratch`
  * `-s` option indicates that you want this scratch org to be the default org for this project when running Salesforce CLI commands.
  * To use a different org on a per command basis, you can specify the `-u` argument and specify another alias.
  * `-f` option is the path to the project scratch org configuration file.
  * `-a` refer to the org using its alias.

### Create a project (geolocation)
* `sfdx force:project:create -n geolocation`

### Create Sample Data
* Create the Marriott Marquis account: `sfdx force:data:record:create -s Account -v 'Name="Marriott Marquis" BillingStreet="780 Mission St" BillingCity="San Francisco" BillingState="CA" BillingPostalCode="94103" Phone="(415) 896-1600" Website="www.marriott.com"'`
#### Export sample data:
* `sfdx force:data:tree:export -q "SELECT Name, BillingStreet, BillingCity, BillingState, BillingPostalCode, Phone, Website FROM Account WHERE BillingStreet != NULL AND BillingCity != NULL and BillingState != NULL" -d ./data`
#### Import sample data:
* `sfdx force:data:tree:import --sobjecttreefiles data/Account.json`
### Open your Dev Hub org.
* If you already authorized the Dev Hub, open it: `sfdx force:org:open -u DevHub`
* If you haven’t yet logged in to your Dev Hub org: `sfdx force:auth:web:login -d -a DevHub`
* List your orgs: `sfdx force:org:list`
### Test the JWT Auth Flow
`sfdx force:auth:jwt:grant --clientid ${CONSUMER_KEY} --username ${HUB_USERNAME} \
--jwtkeyfile ${JWT_KEY_FILE} --setdefaultdevhubusername`
### Help
* All the available topics: `sfdx force --help`
* All available commands: `sfdx force:doc:commands:list`
### Log In to the Dev Hub
* `sfdx force:auth:web:login -h`
* `sfdx force:auth:web:login --help`

### Log In to Sandboxes
* `sfdx force:auth:web:login -r https://test.salesforce.com -a FullSandbox`
* `sfdx force:auth:web:login -r https://test.salesforce.com -a DevSandbox`

### Aliasing
* `sfdx force:org:open -u FullSandbox`
* `sfdx force:org:open -u MyScratchOrg`
* `sfdx force:limits:api:display -u DevSandbox`
