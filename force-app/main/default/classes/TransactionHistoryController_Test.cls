@isTest
public class TransactionHistoryController_Test {	
    
    public static Financial_Accounts__c financialAccRec = new Financial_Accounts__c();
        
    @testSetup
    static void setUpData(){
        //Test Setup
        General_Configurations__c genConfig =  TestDataFactory.creategenralConfiguration();
        List<ACME_TransactionHistory__b> transactionList = TestDataFactory.createTransactionHistory(10, 'IAB100000085');
        
        financialAccRec = TestDataFactory.createFinancialAcc('IAB100000085');
    }
    static testmethod void doPost_Test(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
		String jsonReq = '[{"abid": "IAB100000085","accountNumber": 18171617,"amount": 2000.59,"transactionCurrency": "AUD","transactiondate": "2019-09-07","merchantABN": 123456789,"merchantBSB": 123456,"merchantName": "Beau Flowers","transactiontime": "17:32:25","transactionType": "debit"}]';        
        req.requestURI = '/services/apexrest/api/ACME_TransactionHistory__b/';
        req.requestURI = '/services/apexrest/DemoUrl';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonReq);
        RestContext.request = req;
        RestContext.response= res;
        
        //Test Scenario
        Test.startTest();
        TransactionHistoryController.doPost();
        Test.stopTest();
        
        //system.assert([Select Id from ACME_TransactionHistory__b].size()>0);

    }
}