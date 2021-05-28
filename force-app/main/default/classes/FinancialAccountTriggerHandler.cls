public without sharing class FinancialAccountTriggerHandler {
    
    public static void generateABID(List <Financial_Accounts__c> financialAccounts){
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        
		General_Configurations__c  genConfig = General_Configurations__c.getValues('ABID');
        for(Financial_Accounts__c accountRec :financialAccounts){
            String TransactionId = '';
            Integer randomCount = 0;
            do{
                randomCount = Math.round(Math.random()*99);
            } while(randomCount == 0);

            Integer TransactionNo = Integer.valueOf(genConfig.NumericValue__c + randomCount);
            if(accountRec.Acme_Bank_Unique_ID__c == null){
                TransactionId = String.valueOf(TransactionNo);
            }	
            accountRec.Acme_Bank_Unique_ID__c = TransactionId.length()>9?genConfig.TextValue__c+TransactionId.substring(TransactionId.length() - 9):genConfig.TextValue__c+TransactionId;
            updatedFinancialAccs.add(accountRec);
      
            genConfig.NumericValue__c = TransactionNo;
            
        }
        update genConfig;
    }
}