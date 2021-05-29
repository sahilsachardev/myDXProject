@RestResource(urlMapping='/api/ACME_Transaction_History__b/*')
global with sharing class TransactionHistoryController
{
    @HttpPost
    global static String doPost() {
        String data = RestContext.request.requestBody.toString();
        List<TransactionHistoryWrapper> transactionDataList = new List<TransactionHistoryWrapper>();
        transactionDataList = (List<TransactionHistoryWrapper>)JSON.deserialize(data, List<TransactionHistoryWrapper>.class);        
        system.debug('>>transactionDataList>> '+transactionDataList);
        
        List<ACME_Transaction_History__b> transactionHistoryList = new List<ACME_Transaction_History__b>();  
        List<Database.SaveResult> saveResults = new List<Database.SaveResult>();
        General_Configurations__c genConfig = General_Configurations__c.getValues('TransactionId');
        String response;
        
        if(!transactionDataList.isEmpty()){
            for(TransactionHistoryWrapper transactionData :transactionDataList){
                ACME_Transaction_History__b transactionHistoryRec = new ACME_Transaction_History__b();
                transactionHistoryRec.ABID__c = transactionData.abid.deleteWhitespace();
                transactionHistoryRec.Amount__c = transactionData.amount;
                transactionHistoryRec.Currency__c = transactionData.transactionCurrency.trim();
                transactionHistoryRec.Transaction_Date__c = Datetime.newInstance(transactionData.transactiondate, transactionData.transactiontime);
                transactionHistoryRec.Type__c = transactionData.transactionType.trim();
                transactionHistoryRec.MerchantABN__c = transactionData.merchantABN;
                transactionHistoryRec.MerchantBSB__c = transactionData.merchantBSB;
                transactionHistoryRec.MerchantName__c = transactionData.merchantName;
                transactionHistoryRec.Transaction_Id__c = genConfig.NumericValue__c+1;
                
                
                transactionHistoryList.add(transactionHistoryRec);
                genConfig.NumericValue__c += 1;
            }
            
        }
                              
        //try{
        if(!transactionHistoryList.isEmpty()){
            saveResults = Database.insertImmediate(transactionHistoryList); 
            update genConfig;
        	system.debug('>>saveResults>>'+saveResults);
            for (Database.SaveResult result : saveResults) {
                if (result.isSuccess()) {
                    response = 'Success';
                }else{
                    response = 'Error';
                    break;
                }
            }
        }
        //}catch(Exception err){
        //    System.debug('Exception!! - '+err.getMessage());
        //}
        
        return response;
	}

}