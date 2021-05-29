@RestResource(urlMapping='/api/TransactionHistory__b/*')
global with sharing class TransactionHistoryController
{
    @HttpPost
    global static String doPost() {
        system.debug('>>postTransactionHistory>>');
        //TransactionHistoryWrapper transactionData = new TransactionHistoryWrapper();
        //transactionData = data;
        String data = RestContext.request.requestBody.toString();
        List<TransactionHistoryWrapper> transactionDataList = new List<TransactionHistoryWrapper>();
        transactionDataList = (List<TransactionHistoryWrapper>)JSON.deserialize(data, List<TransactionHistoryWrapper>.class);
        //TransactionHistoryWrapper transactionData = (TransactionHistoryWrapper)JSON.deserializeStrict(data, TransactionHistoryWrapper.class);
        
        system.debug('>>transactionDataList>> '+transactionDataList);
        
        List<TransactionHistory__b> transactionHistoryList = new List<TransactionHistory__b>();  
        List<Database.SaveResult> saveResults = new List<Database.SaveResult>();
        String response;
        
        if(!transactionDataList.isEmpty()){
            for(TransactionHistoryWrapper transactionData :transactionDataList){
                TransactionHistory__b transactionHistoryRec = new TransactionHistory__b();
                transactionHistoryRec.ABID__c = transactionData.abid.deleteWhitespace();
                transactionHistoryRec.Amount__c = transactionData.amount;
                transactionHistoryRec.Currency__c = transactionData.transactionCurrency.trim();
                transactionHistoryRec.Transaction_Date__c = Datetime.newInstance(transactionData.transactiondate, transactionData.transactiontime);
                transactionHistoryRec.Type__c = transactionData.transactionType.trim();
                transactionHistoryRec.MerchantABN__c = transactionData.merchantABN;
                transactionHistoryRec.MerchantBSB__c = transactionData.merchantBSB;
                transactionHistoryRec.MerchantName__c = transactionData.merchantName;
                
                transactionHistoryList.add(transactionHistoryRec);
            }
            
        }
                              
        //try{
            if(!transactionHistoryList.isEmpty())
            saveResults = Database.insertImmediate(transactionHistoryList); 
        	system.debug('>>saveResults>>'+saveResults);
            for (Database.SaveResult result : saveResults) {
                if (result.isSuccess()) {
                    response = 'Success';
                }else{
                    response = 'Error';
                    break;
                }
            }
        //}catch(Exception err){
        //    System.debug('Exception!! - '+err.getMessage());
        //}
        
        return response;
	}

}