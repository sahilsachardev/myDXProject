## Some Limitations and considerations
- DML Operations on Transaction_History__b (Big Object) could have been an Asynchronous executions, but is currently set as synchronous (insertimmediate) as Async Operation (Asyncinsert) was not enabled in the scratch Org.
- Person Accounts should have been an ideal solutoin to link Financial_Account__c (custom Object) records. However, to enable Person Account we need to contact Salesforce Support. Please consider Finantial_Account__c implementation similar to Person Accounts.

## Setup Integration to Perform Transaction History request.

### Setup Connect App

Step 1: Create a new Connect App in Salesforce with following details

    Connected App Name	            = [ACME Transactions]
    API Name	                    = [ACME_Transactions]
    Contact Email	                = EmailAddress
    Enable OAuth Settings	        = Check
    Callback URL                    = https://login.salesforce.com/services/oauth2/success
    Selected OAuth Scopes	        = Access and manage your data (api)
                                    Provide access to your data via the Web (web)
    Require Secret for Web Server Flow = True

Step 2: SAVE

## Generate Access Token
## Please Install Postman to achieve this for better results.

Method = [POST]

[URL_Instance]services/oauth2/token?grant_type=password&client_id=[Consumer_Key]&client_secret=[Client_secret]&&username=iuser@acme.com.scratchorg&password=integrationuser123

Map below strings [] or [URL_Instance] with the relevant value
[URL_Instance]  = Domain URL.
Consumer_Key    = Consumer Key from Connected App.
Client_secret   = Client secret from Connect App.

Eg: Please refer below link to access my current Scratch Org.
URL:    [https://business-flow-21732-dev-ed.cs6.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9e2mBbZnmM6mB2yJqiNXpa.mcXk_DVKwskSZlU5I9mG0a7Cq4.o2H7NfzTHD575SOlbLOQiQpggWVF.GR&client_secret=2D6876349F96B10A9CA0005A4A69A7924576681123A49B50FDDE62EF59709024&username=iuser@acme.com.scratchorg&password=integrationuser123]

## Expected Response . Please note access_token
{
    "access_token": "00DN0000000GEML!AR0AQCzsWPdn_YM.B3RfXFRSI87Fb2cxBd0j_WehOkyWEk8UuGFH6LR2H0ra6fS50QUT_NkI26KQ2ypsjMr7sPHsEBHe5KwG",
    "instance_url": "https://business-flow-21732-dev-ed.cs6.my.salesforce.com",
    "id": "https://test.salesforce.com/id/00DN0000000GEMLMA4/005N000000A4IOWIA3",
    "token_type": "Bearer",
    "issued_at": "1622218562874",
    "signature": "KeruP53qJf6HUL9a5B47D0V5BqQNl5WU/T7sn4X5gb4="
}

## Request to insert Transaction History.
## In case of new Financial Account system will automaticaly create a new Finantial Account, Store Transaction History and Calculate the Balance.

URL: [https://business-flow-21732-dev-ed.cs6.my.salesforce.com/services/apexrest/api/TransactionHistory__b]

Authorization: Token = [Access_Tocken] Press "Send"

Body: 

Request for Single Transactions: [{"abid": "ACM100000085","accountNumber": 18171617,"amount": 2000.59,"transactionCurrency": "AUD","transactiondate": "2019-09-07","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"}]

Request for Bulk Transactions: [{"abid": "ACM100000081","accountNumber": 18171617,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-07-02","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "credit"},{"abid": "ACM 123 456 100","accountNumber": 18171617,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-07-03","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "credit"},{"abid": "ACM100000085","accountNumber": 18171617,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-08-04","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "credit"},{"abid": "ACM100000081","accountNumber": 18171617,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-07-05","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "credit"},{"abid": "ACM100000085","accountNumber": 18171617,"amount": 2000.59,"transactionCurrency": "AUD","transactiondate": "2019-09-07","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-07","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-08","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-02","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-03","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-04","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-05","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-06","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-07","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"},{"abid": "ACM 123 456 799","accountNumber": 18171615,"amount": 200.59,"transactionCurrency": "AUD","transactiondate": "2019-06-08","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"}]