public without sharing class FinancialAccountTriggerHandler {
    
    public static void generateABID(List <Financial_Accounts__c> financialAccounts){
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        
		General_Configurations__c  genConfig = General_Configurations__c.getValues('ABID');
        for(Financial_Accounts__c accountRec :financialAccounts){
            system.debug('>> '+accountRec);
            String TransactionId = '';
            Integer randomCount = Math.round(Math.random()*99);
            if(accountRec.Acme_Bank_Unique_ID__c == null){
                //String.ValueOf(System.Now()).replaceAll('[^\\d]','')+String.valueOf(Math.round(Math.random()*9))+String.valueOf(randomCount)
                TransactionId = String.valueOf(genConfig.NumericValue__c + randomCount);
            }	
            accountRec.Acme_Bank_Unique_ID__c = TransactionId.length()>9?genConfig.TextValue__c+TransactionId.substring(TransactionId.length() - 9):genConfig.TextValue__c+TransactionId;
            updatedFinancialAccs.add(accountRec);
      
            genConfig.NumericValue__c += randomCount;
            system.debug('>>genConfig randomCount>>'+genConfig);
        }
        //try{
            update genConfig;
            //Database.insert(updatedFinancialAccs);
        //}catch(Exception err){
        //    System.debug('Exception- '+err.getMessage());
        //}        
    }
}