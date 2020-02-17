# Account Trigger on update
The following classes and trigger are added in this assignment.
### AccountTriggerService.cls
This class is used for making a service layer to write the business logic of AccountTrigger.
### AccountTrigger.trigger: 
This is used for defining the trigger which will only be trigger after insert and update one or multiple account objects.
### AccountTriggerTest.cls: 
This is used for testing AccountTrigger
### TestDataFactory.cls: 
This is used for populating test data.

# Running Test
This example has been tested in VSCode by following action:
> SFDX: authorize an org
> SFDX: Deploy source in menifest to org
> Run test in edit.