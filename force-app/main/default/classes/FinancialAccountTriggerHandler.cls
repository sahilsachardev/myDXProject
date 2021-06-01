/********************************************************************************
 * @Class name:    FinancialAccountTriggerHandler
 * @description:   Financial Account Trigger Handler to perform all the logics.
 * @testclass:     FinancialAccountTrigger_Test
 * @trigger:       FinancialAccount_Trigger
 * HISTORY *
 ===========
 Auther         Date                Comment
*********************************************************************************/

public without sharing class FinancialAccountTriggerHandler {
    
    public static void generateABID(List <Financial_Accounts__c> financialAccounts){
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        
        General_Configurations__c genConfig = General_Configurations__c.getValues('ABID');
		String UniqueId = '';
        Integer randomCount = 0;        
        for(Financial_Accounts__c accountRec :financialAccounts){
           
            //Generate Unique ABID
            //Below code will generate a unique 2 digit number and add it to the custom setting neumeric value which will give a unique 9 digit ABIDs and add Text value as a prefix.
            // Eg: XXX1000000029
            //ABID getting generated within Salesforce can be differentiated with the ABIDs getting populated from Transaction History service request by the first three characters.
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