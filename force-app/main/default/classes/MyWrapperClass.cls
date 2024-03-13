public class MyWrapperClass {
    public static void ObjectData(String AccountId, String OpportunityId){
         List<objectDataWrapper> dataWrapper = new List<objectDataWrapper>();
       
        List<Account> accList = [select Id, Name, Phone from Account where Id =: AccountId];
        for(Account ac: accList){
            objectDataWrapper t = new objectDataWrapper();
            
            t.accname = ac.Name;
            t.accphone = ac.Phone;
            dataWrapper.add(t);
        }
        System.debug('This is the list' + dataWrapper);
        List<Opportunity> oppList = [select Id, createdDate, Name from Opportunity where Id =: OpportunityId];
        for(Opportunity op: oppList){
            dataWrapper[0].oppcreatedDate = string.valueof(op.createdDate);
        }
 System.debug('This is the list2' + dataWrapper);
    }
     public class  objectDataWrapper{
        @AuraEnabled public String accname; 
         @AuraEnabled public String accphone;
          @AuraEnabled public String oppcreatedDate;
          @AuraEnabled public String oppname;
     }
}