public class Utility {
    
    public static String getUniqueId(String FieldName){
        
		General_Configurations__c genConfig = General_Configurations__c.getValues(FieldName);
        String UniqueId = '';
        Integer randomCount = 0;
        do{
            randomCount = Math.round(Math.random()*99);
        } while(randomCount == 0);
        Integer TransactionNo = Integer.valueOf(genConfig.NumericValue__c + randomCount);
        UniqueId = String.valueOf(TransactionNo);
        if(genConfig.Name == 'ABID'){
        	UniqueId = UniqueId.length()>9?genConfig.TextValue__c+UniqueId.substring(UniqueId.length() - 9):genConfig.TextValue__c+UniqueId;
        }else{
            UniqueId = UniqueId;
        }
        
        genConfig.NumericValue__c = TransactionNo;        
        update genConfig;
        return UniqueId;
    }

}