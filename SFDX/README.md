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
* sfdx force:lightning:component:create -n myFirstWebComponent -d force-app/main/default/lwc --type lwc
  * -n — This defines the name of the Lightning web component folder and its files
  * -d — This defines the target directory where the Lightning web component should be created. The target directory must be named lwc
  * --type — This specifies that you want to create a Lightning Web Component
#
### Open your Dev Hub org.
* If you already authorized the Dev Hub, open it: `sfdx force:org:open -u DevHub`
* If you haven’t yet logged in to your Dev Hub org: `sfdx force:auth:web:login -d -a DevHub`
 
