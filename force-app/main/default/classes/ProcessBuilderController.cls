public class ProcessBuilderController {
	
    @InvocableMethod
    public static void FinancialAccountProcessBuilder(List<Financial_Accounts__c> financialAccountList){
        
        Map<String, Id> abidIds = new Map<String, Id>();
        for(Financial_Accounts__c financialAcc :financialAccountList){
            if(financialAcc.Balance_Calculation__c == 'Pending' && financialAcc.Acme_Bank_Unique_ID__c != null){
                abidIds.put(financialAcc.Acme_Bank_Unique_ID__c, financialAcc.Id);
            }
        }
        CalculateTransactionBalance(abidIds);
    }
    @future
    public static void CalculateTransactionBalance(Map<String, Id> abidIds){
        
        List<Financial_Accounts__c> updatedFinancialAccs = new List<Financial_Accounts__c>();
        Map<Id,Decimal> mapCalculateAmt = new Map<Id,Decimal>();
        for(ACME_TransactionHistory__b tranHistory : [SELECT Id, createddate, ABID__c, Amount__c, Transaction_Date__c, Type__c, Transaction_Id__c FROM ACME_TransactionHistory__b  WHERE ABID__c IN:abidIds.keySet() LIMIT 40000]){
            if(mapCalculateAmt.containsKey(abidIds.get(tranHistory.ABID__c))){
                Decimal currentCalculatedvalue = mapCalculateAmt.get(abidIds.get(tranHistory.ABID__c));
                Decimal calculatedvalue = tranHistory.Type__c == 'debit'?currentCalculatedvalue + tranHistory.Amount__c:currentCalculatedvalue - tranHistory.Amount__c;
                mapCalculateAmt.put(abidIds.get(tranHistory.ABID__c), calculatedvalue);
            }else{
                Decimal calculatedvalue = tranHistory.Type__c == 'debit'?0.00 + tranHistory.Amount__c:0.00 - tranHistory.Amount__c;
                mapCalculateAmt.put(abidIds.get(tranHistory.ABID__c), calculatedvalue);
            }
        }
        for(Id finAccRec:abidIds.values()){
            if(mapCalculateAmt.containsKey(finAccRec)){
                Financial_Accounts__c updatedfinAccRec = new Financial_Accounts__c(Id=finAccRec);
                updatedfinAccRec.Balance_Amount__c = mapCalculateAmt.get(finAccRec);
                updatedfinAccRec.Balance_Calculation__c = 'Calculated';
                
                updatedFinancialAccs.add(updatedfinAccRec);
            }
        }
        system.debug('>>updatedFinancialAccs>>'+updatedFinancialAccs);
        //try{
        	if(!updatedFinancialAccs.isEmpty())
            Database.update(updatedFinancialAccs);
        //}catch(){
            
        //}
    }
}