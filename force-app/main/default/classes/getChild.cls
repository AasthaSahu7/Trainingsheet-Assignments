public class getChild{
    
@AuraEnabled
public static List<Mentor2__c> getStudentDetails(){
    
        List<Mentor2__c> studList = [SELECT Id , Name__c, Designation__c, StudentsNumber__c,(SELECT Name, Class__c, City__c FROM Students__r) 
                                   FROM Mentor2__c];
    
    if(!studList.isEmpty()){
        return studList;
    }
        return null;
    }
}