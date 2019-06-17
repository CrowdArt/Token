## [Considerations for Sending List Email in Lightning Experience](https://help.salesforce.com/articleView?id=email_list_email_considerations.htm&type=5)
* List email is available in company communities only.
* Campaign merge fields can’t be used in list emails.
* To log list email activities, list email logging must be enabled. It is on by default.

* A list email isn’t sent if any of the following are true:
  * An email has bounced.
  * A recipient is missing an email address.
  * A recipient (contact, lead, or person account) selected Email Opt Out.
* If Enforce email privacy setting is enabled, a list email isn’t sent if any of the following are also true:
  * A recipient selected Don’t Process.
  * A recipient selected Don’t Market.
  * A recipient selected Forget this Individual.
  * The Individual record is missing.
