# Salesforce DX and Git
## Dev Guides
* [Salesforce DX Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
* [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
* [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.220.0.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)

## Create App
* `sfdx force:apex:class:create -n AccountSearchController -d force-app/main/default/classes`
* Create an org with the alias GeoAppScratch: `sfdx force:org:create -s -f config/sfdx-project.json -a GeoApp`
* `sfdx force:org:create --setdefaultusername -f config/project-scratch-def.json --setalias my-scratch-org`


## Commands
* Display API limits: `sfdx force:limits:api:display -u DevHub`
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
  * `sfdx force:apex:test:run -u vuk1@crowdart.io --testlevel=RunLocalTests`
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
  * `sfdx force:org:create -s -f config/

### Create a project (geolocation)
* `sfdx force:project:create -n geolocation`

### Create Aura component
* Create the AccountMap component in the aura folder: `sfdx force:lightning:component:create -n AccountMap -d force-app/main/default/aura`
* Push your new code to the org: `sfdx force:source:push`

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

## Deploy metadata to an org using Metadata API

USAGE
$ sfdx force:mdapi:deploy [-c | -i <id>] [-d <directory> | -f <filepath>] [-w <minutes>] [-l 
NoTestRun|RunSpecifiedTests|RunLocalTests|RunAllTestsInOrg] [-r <array>] [-e true|false] [-o] [-g] [-q <id>] [-u <string>] [--apiversion 
  <string>] [--verbose] [--json] [--loglevel trace|debug|info|warn|error|fatal|TRACE|DEBUG|INFO|WARN|ERROR|FATAL]

OPTIONS
  -c, --checkonly                                                                   validate deploy but don’t save to the org
  -d, --deploydir=deploydir                                                         root of directory tree of files to deploy
  -e, --rollbackonerror=(true|false)                                                (deprecated) roll back deployment for any failure
  -f, --zipfile=zipfile                                                             path to .zip file of metadata to deploy

  -g, --ignorewarnings                                                              whether a warning will allow a deployment to complete 
                                                                                    successfully

  -i, --jobid=jobid                                                                 (deprecated) job ID of the deployment you want to check; 
                                                                                    defaults to your most recent CLI deployment if not 
                                                                                    specified

  -l, --testlevel=(NoTestRun|RunSpecifiedTests|RunLocalTests|RunAllTestsInOrg)      deployment testing level

  -o, --ignoreerrors                                                                ignore any errors and do not roll back deployment

  -q, --validateddeployrequestid=validateddeployrequestid                           request ID of the validated deployment to run a Quick 
                                                                                    Deploy

  -r, --runtests=runtests                                                           tests to run if --testlevel RunSpecifiedTests

  -u, --targetusername=targetusername                                               username or alias for the target org; overrides default 
                                                                                    target org

  -w, --wait=wait                                                                   wait time for command to finish in minutes (default: 0)

  --apiversion=apiversion                                                           override the api version used for api requests made by 
                                                                                    this command

  --json                                                                            format output as json

  --loglevel=(trace|debug|info|warn|error|fatal|TRACE|DEBUG|INFO|WARN|ERROR|FATAL)  [default: warn] logging level for this command invocation

  --verbose                                                                         verbose output of deploy results

DESCRIPTION
  Specify the location of the files to deploy as a .zip file or by the root of the directory tree containing the files. To check the status 
  of a deployment, specify its job ID. To run quick deploy of a recently validated package, use --validateddeployrequestid with the validated 
  ID.

  The default value of --rollbackonerror is true, but the corresponding parameter in the Metadata API deploy() call defaults to false.

  To wait for the command to finish running no matter how long the deployment takes, set --wait to -1: "sfdx force mdapi:deploy -w -1 ...".

COMMANDS
  force:mdapi:deploy:cancel  cancel a metadata deployment
  force:mdapi:deploy:report  check the status of a metadata deployment


