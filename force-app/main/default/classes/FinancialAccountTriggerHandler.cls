public without sharing class FinancialAccountTriggerHandler {
    
    public static void generateABID(List <Financial_Accounts__c> financialAccounts){
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        
        General_Configurations__c genConfig = General_Configurations__c.getValues('ABID');
		String UniqueId = '';
        Integer randomCount = 0;        
        for(Financial_Accounts__c accountRec :financialAccounts){
           
            if(accountRec.Acme_Bank_Unique_ID__c == null){
                do{
                    randomCount = Math.round(Math.random()*99);
                } while(randomCount == 0);
                Integer TransactionNo = Integer.valueOf(genConfig.NumericValue__c + randomCount);
                UniqueId = String.valueOf(TransactionNo);
                UniqueId = UniqueId.length()>9?genConfig.TextValue__c+UniqueId.substring(UniqueId.length() - 9):genConfig.TextValue__c+UniqueId;
                accountRec.Acme_Bank_Unique_ID__c = UniqueId;
                
                genConfig.NumericValue__c = TransactionNo;        
            }	
            updatedFinancialAccs.add(accountRec);
        }
        update genConfig;
    }
    
}