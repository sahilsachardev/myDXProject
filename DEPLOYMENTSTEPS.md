## PRE Deployment Steps


## POST Deployment Steps

- Financial_Account__C.Acme_Bank_Unique_ID__c - Set Feed tracking enable.
- Execute scripts in the new Scratch Org.
    COMMAND: sfdx force:apex:execute -f scripts/apex/GeneralConfiguration.apex
- Enable Feed Tracking for Finantial_Accounts__C for below fields
    Customer Name, Address, Phone, Email and Acme Bank Unique ID (ABID).
- Profile - System Admin - Check Enable access for Connected App 'ACME Transactions' under Connected App Access.
- ACME Bank App - App Manager - give profile access to ACME Bank.