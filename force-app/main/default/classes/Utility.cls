public class Utility {
    
    public static String getABID(String FieldName){
        
		General_Configurations__c genConfig = General_Configurations__c.getValues(FieldName);
        String TransactionId = '';
        Integer randomCount = 0;
        do{
            randomCount = Math.round(Math.random()*99);
        } while(randomCount == 0);
        Integer TransactionNo = Integer.valueOf(genConfig.NumericValue__c + randomCount);
        TransactionId = String.valueOf(TransactionNo);
        TransactionId = TransactionId.length()>9?genConfig.TextValue__c+TransactionId.substring(TransactionId.length() - 9):genConfig.TextValue__c+TransactionId;
        genConfig.NumericValue__c = TransactionNo;        
        update genConfig;
        return TransactionId;
    }

}