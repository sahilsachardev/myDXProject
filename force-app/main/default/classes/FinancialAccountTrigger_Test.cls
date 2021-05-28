@isTest
public class FinancialAccountTrigger_Test {
	
    @isTest
    public static void generateABID_Test(){
        //Test Setup
        General_Configurations__c genConfig =  TestDataFactory.creategenralConfiguration();
            
        //Test Scenario
        Test.startTest();
        Financial_Accounts__c financialAccRec = TestDataFactory.createFinancialAcc();
        system.assert(financialAccRec.Acme_Bank_Unique_ID__c != null || financialAccRec.Acme_Bank_Unique_ID__c != '');
        Test.stopTest();
    }
    @isTest
    public static void generateABID_TestBulk(){
        //Test Setup
        General_Configurations__c genConfig =  TestDataFactory.creategenralConfiguration();
            
        //Test Scenario
        Test.startTest();
        List<Financial_Accounts__c> financialAccRec = TestDataFactory.createFinancialAcc(500);
        List<Financial_Accounts__c> CountRec = [Select id from Financial_Accounts__c Where Acme_Bank_Unique_ID__c != ''];
        system.assert(CountRec.size() == 500);
        Test.stopTest();
    }
}