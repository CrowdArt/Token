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
* 
