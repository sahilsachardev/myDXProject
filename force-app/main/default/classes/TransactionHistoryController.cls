/**********************************************************************************************
 * @Class name:     TransactionHistoryController
 * @description:    With sharing api service to populate Transaction History and Financial 
                    Account records when a POST request reaches. This is an Idempotent service
                    and duplicate transactions will not create another record.
 * HISTORY *
 ===========
 Auther         Date                Comment
***********************************************************************************************/

@RestResource(urlMapping='/api/ACME_TransactionHistory__b/*')
global with sharing class TransactionHistoryController
{
    @HttpPost
    global static String doPost() {
        String data = RestContext.request.requestBody.toString();
        List<TransactionHistoryWrapper> transactionDataList = new List<TransactionHistoryWrapper>();
        transactionDataList = (List<TransactionHistoryWrapper>)JSON.deserialize(data, List<TransactionHistoryWrapper>.class);        
        
        List<ACME_TransactionHistory__b> transactionHistoryList = new List<ACME_TransactionHistory__b>(); 
        List<Financial_Accounts__c> updatedfinAccs = new List<Financial_Accounts__c>(); 
        Map<String, Financial_Accounts__c> finAccAbidId = new Map<String, Financial_Accounts__c>();
        List<Financial_Accounts__c> newfinAccs = new List<Financial_Accounts__c>();
        Map<String, Financial_Accounts__c> mapExistingfinAccs = new Map<String, Financial_Accounts__c>();
        List<Database.SaveResult> saveResults = new List<Database.SaveResult>();
        General_Configurations__c genConfig = General_Configurations__c.getValues('TransactionId');
        String response;
        
        if(!transactionDataList.isEmpty()){
            for(TransactionHistoryWrapper transactionData :transactionDataList){
                //Populate New Transaction History Records
                ACME_TransactionHistory__b transactionHistoryRec = new ACME_TransactionHistory__b();
                transactionHistoryRec.ABID__c = transactionData.abid.deleteWhitespace();
                transactionHistoryRec.AccountNumber__c = transactionData.accountNumber;
                transactionHistoryRec.Amount__c = transactionData.amount;
                transactionHistoryRec.Currency__c = transactionData.transactionCurrency.trim();
                transactionHistoryRec.Transaction_Date__c = Datetime.newInstance(transactionData.transactiondate, transactionData.transactiontime);
                transactionHistoryRec.Type__c = transactionData.transactionType.trim();
                transactionHistoryRec.MerchantABN__c = transactionData.merchantABN;
                transactionHistoryRec.MerchantBSB__c = transactionData.merchantBSB;
                transactionHistoryRec.MerchantName__c = transactionData.merchantName;
                transactionHistoryRec.Transaction_Id__c = genConfig.NumericValue__c+1;
                
                //Populate New Financial Accounts for new ABIDs.
                Financial_Accounts__c financialAccRec = new Financial_Accounts__c();
                financialAccRec.Acme_Bank_Unique_ID__c = transactionData.abid.deleteWhitespace();
                financialAccRec.Account_Number__c = transactionData.accountNumber;
                financialAccRec.Balance_Calculation__c = 'Pending';
                financialAccRec.IsActive__c = true;
                financialAccRec.Type__c = 'Savings';
                financialAccRec.Name = transactionData.merchantName;
                    
                transactionHistoryList.add(transactionHistoryRec);
                finAccAbidId.put(transactionData.abid.deleteWhitespace(), financialAccRec);
                genConfig.NumericValue__c += 1;
            }
            
            //Check for new and existing Financial Accounts in System.
            for(Financial_Accounts__c existingfinAccRec :[Select Id, Name, Acme_Bank_Unique_ID__c, Account_Number__c, Type__c from Financial_Accounts__c Where Acme_Bank_Unique_ID__c IN:finAccAbidId.keySet()]){
                if(existingfinAccRec.Acme_Bank_Unique_ID__c != null)
                mapExistingfinAccs.put(existingfinAccRec.Acme_Bank_Unique_ID__c, existingfinAccRec);
            }
            if(mapExistingfinAccs.isEmpty()){
            	newfinAccs.addAll(finAccAbidId.values());
            }else{
                for(Financial_Accounts__c finAccRec :finAccAbidId.values()){
                    if(mapExistingfinAccs.containsKey(finAccRec.Acme_Bank_Unique_ID__c)){
                        Financial_Accounts__c existingFAcc = mapExistingfinAccs.get(finAccRec.Acme_Bank_Unique_ID__c);
                        existingFAcc.Balance_Calculation__c = 'Pending';
                        updatedfinAccs.add(existingFAcc);
                    }else{
                        newfinAccs.add(finAccAbidId.get(finAccRec.Acme_Bank_Unique_ID__c));
                    }
                }
            }
        }
                              
        try{
            if(!transactionHistoryList.isEmpty()){
                //Asynchronous DMl Operations are not enable in this Org.
                //Considering insertion synchronously. 
                if(!Test.isRunningTest())
                saveResults = Database.insertImmediate(transactionHistoryList); 
                if(!newfinAccs.isEmpty()){
                insert newfinAccs;
                }
                if(!updatedfinAccs.isEmpty()){
                update updatedfinAccs;
                }
                update genConfig;
                for (Database.SaveResult result : saveResults) {
                    if (result.isSuccess()) {
                        response = 'Success';
                    }else{
                        response = 'Error';
                        break;
                    }
                }
            }
        }catch(Exception err){
            // A new Error Log Custom Object can be created to log failures.
            System.debug('Exception!! - '+err.getMessage());
            response = 'Exception!! - '+err.getMessage();
        }
        return response;
	}
}