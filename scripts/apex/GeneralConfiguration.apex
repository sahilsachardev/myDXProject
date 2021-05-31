
// Script to populate General Configuration Custom Settings.

List <General_Configurations__c> genConfiglist = new List<General_Configurations__c>();
General_Configurations__c genConfig = new General_Configurations__c(Name = 'TransactionId',
                                                                    FieldName__c = 'Transaction_Id__c',
                                                                    isActive__c = true,
                                                                    NumericValue__c=100001
                                                                   );
genConfiglist.add(genConfig);
insert genConfiglist;

General_Configurations__c genConfig2 = new General_Configurations__c(Name = 'ABID',
                                                                            FieldName__c = 'Acme_Bank_Unique_ID__c',
                                                                            isActive__c = true,
                                                                            NumericValue__c=100000001,
                                                                            TextValue__c='ABK'
                                                                           );
genConfiglist.add(genConfig2);


insert genConfig2;