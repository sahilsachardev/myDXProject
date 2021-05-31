trigger FinancialAccount_Trigger on Financial_Accounts__c (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        FinancialAccountTriggerHandler.generateABID(Trigger.new);
    }

}