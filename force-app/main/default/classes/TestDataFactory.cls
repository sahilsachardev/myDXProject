/**********************************************************************************************
 * @Class name:     TestDataFactory
 * @description:    Data Factory for Test Classes.
 * @testclass:      FinancialAccountTrigger_Test and TransactionHistoryController_Test
 * HISTORY *
 ===========
 Auther         Date                Comment
***********************************************************************************************/

public class TestDataFactory {

    public static General_Configurations__c  creategenralConfiguration(){
        
        General_Configurations__c genConfig = new General_Configurations__c(Name = 'ABID',
                                                                            FieldName__c = 'Acme_Bank_Unique_ID__c',
                                                                            isActive__c = true,
                                                                            NumericValue__c=100000001,
                                                                            TextValue__c='ABK'
                                                                           );
        insert genConfig;
        General_Configurations__c genConfigTranId = new General_Configurations__c(Name = 'TransactionId',
                                                                            FieldName__c = 'Transaction_Id__c',
                                                                            isActive__c = true,
                                                                            NumericValue__c=100001
                                                                           );
        insert genConfigTranId;
        return genConfig;
    }
    
    public static Financial_Accounts__c createFinancialAcc(String ABID){
        
        Financial_Accounts__c finantialAcc = new Financial_Accounts__c();
        finantialAcc.Account_Number__c = 123456789;
        finantialAcc.Acme_Bank_Unique_ID__c = ABID;
        finantialAcc.Address__c = 'Sydney 2000, NSW, Australia'; 
        finantialAcc.Balance_Amount__c = 0;
        finantialAcc.Email__c = 'sam.test@test.com';
        finantialAcc.IsActive__c = true;
        finantialAcc.Name = 'Sam Test';
        finantialAcc.Phone__c = '0411111111';
        finantialAcc.Type__c = 'Savings';
        finantialAcc.Balance_Calculation__c = 'Pending';
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
    public static List<ACME_TransactionHistory__b> createTransactionHistory(Integer count, String ABID){
        
        List<ACME_TransactionHistory__b> transactionHistoryList = new List<ACME_TransactionHistory__b>();
            
        for(Integer i=0; i<count; i++){
            ACME_TransactionHistory__b transactionHistoryRecds = new ACME_TransactionHistory__b();
            transactionHistoryRecds.ABID__c = ABID;
            transactionHistoryRecds.AccountNumber__c = Integer.valueOf(String.ValueOf(System.Now()).replaceAll('[-: ]','').substring(3, 12));
            transactionHistoryRecds.Amount__c = 150.25;
            transactionHistoryRecds.Currency__c = 'AUD';
            transactionHistoryRecds.MerchantABN__c = 123456789;
            transactionHistoryRecds.MerchantBSB__c = 123456;
            transactionHistoryRecds.MerchantName__c = 'Beau Flowers';
            transactionHistoryRecds.Type__c = 'debit';
            transactionHistoryRecds.Transaction_Date__c = Datetime.newInstance(2021,1,10);
            transactionHistoryRecds.Transaction_Id__c = Integer.ValueOf(Utility.getUniqueId('TransactionId'));
            
            transactionHistoryList.add(transactionHistoryRecds);
        }
        //Database.insert(transactionHistoryList);
        return transactionHistoryList;
    }
}