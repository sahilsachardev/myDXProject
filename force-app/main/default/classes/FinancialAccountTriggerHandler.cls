public without sharing class FinancialAccountTriggerHandler {
    
    public static void generateABID(List <Financial_Accounts__c> financialAccounts){
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        for(Financial_Accounts__c accountRec :financialAccounts){
           
            if(accountRec.Acme_Bank_Unique_ID__c == null){
                accountRec.Acme_Bank_Unique_ID__c = Utility.getABID('ABID');
            }	
            updatedFinancialAccs.add(accountRec);
        }
    }
    
}