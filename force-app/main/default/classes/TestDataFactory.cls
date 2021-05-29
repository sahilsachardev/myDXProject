@isTest
public class TestDataFactory {

    public static General_Configurations__c  creategenralConfiguration(){
        
        General_Configurations__c genConfig = new General_Configurations__c(Name = 'ABID',
                                                                            FieldName__c = 'Acme_Bank_Unique_ID__c',
                                                                            isActive__c = true,
                                                                            NumericValue__c=100000001,
                                                                            TextValue__c='ABK'
                                                                           );
        insert genConfig;
        return genConfig;
    }
    
    public static Financial_Accounts__c createFinancialAcc(){
        
        Financial_Accounts__c finantialAcc = new Financial_Accounts__c();
        finantialAcc.Account_Number__c = 123456789;
        finantialAcc.Address__c = 'Sydney 2000, NSW, Australia';
        finantialAcc.Balance_Amount__c = 0;
        finantialAcc.Email__c = 'sam.test@test.com';
        finantialAcc.IsActive__c = true;
        finantialAcc.Name = 'Sam Test';
        finantialAcc.Phone__c = '0411111111';
        finantialAcc.Type__c = 'Savings';
        insert finantialAcc;
        return finantialAcc;
    }
    public static List<Financial_Accounts__c> createFinancialAcc(Integer count){
        
        List<Financial_Accounts__c> finantialAccounts = new List<Financial_Accounts__c>();
        
        for(Integer i=0; i<count; i++){
            Financial_Accounts__c finantialAcc = new Financial_Accounts__c();
            finantialAcc.Account_Number__c = Integer.valueOf(String.ValueOf(System.Now()).replaceAll('[-: ]','').substring(3, 12));
            finantialAcc.Address__c = 'Sydney 2000, NSW, Australia';
            finantialAcc.Balance_Amount__c = 0;
            finantialAcc.Email__c = 'sam'+count+'.test@test.com';
            finantialAcc.IsActive__c = true;
            finantialAcc.Name = 'Sam'+count+' Test';
            finantialAcc.Phone__c = '04111111'+count+count;
            finantialAcc.Type__c = 'Savings';
            
            finantialAccounts.add(finantialAcc);
        }
        Database.insert(finantialAccounts);
        return finantialAccounts;
    }
    public static List<TransactionHistory__b> createTransactionHistory(Integer count){
        
        List<TransactionHistory__b> transactionHistoryList = new List<TransactionHistory__b>();
        Financial_Accounts__c financialAcc = createFinancialAcc();
            
        for(Integer i=0; i<count; i++){
            TransactionHistory__b transactionHistoryRecds = new TransactionHistory__b();
            transactionHistoryRecds.ABID__c = Utility.getABID('ABID');
            transactionHistoryRecds.AccountNumber__c = Integer.valueOf(String.ValueOf(System.Now()).replaceAll('[-: ]','').substring(3, 12));
            transactionHistoryRecds.Amount__c = 150.25;
            transactionHistoryRecds.Currency__c = 'AUD';
            transactionHistoryRecds.Financial_Account__c = financialAcc.Id;
            transactionHistoryRecds.MerchantABN__c = 123456789;
            transactionHistoryRecds.MerchantBSB__c = 123456;
            transactionHistoryRecds.MerchantName__c = 'Beau Flowers';
            transactionHistoryRecds.Type__c = 'debit';
            transactionHistoryRecds.Transaction_Date__c = Datetime.newInstance(2021,1,10);
            
            transactionHistoryList.add(transactionHistoryRecds);
        }
        Database.insertAsync(transactionHistoryList);
        return transactionHistoryList;
    }
}