global class DeleteStudentRecordsBatch implements Database.Batchable<sObject>, Schedulable{
    
    private Integer deletedStudentCount = 0;
    
/**
description: this method  query the records from the database
params : Database.BatchableContext context
returns : Returns the records fetched by the query
**/    
    global Database.QueryLocator start(Database.BatchableContext context){
        return Database.getQueryLocator([SELECT Id, Mark_Delete__c, Registration_Completed__c, CreatedById FROM Student__c 
                                         WHERE CreatedDate = Last_N_Days:2 AND CreatedDate != LAST_N_DAYS:1]);
        
    }
    
/**
description: this method  checks for the conditions and updates the studentList
params : Database.BatchableContext contex ,  List<Student__c> studentList
returns : Returns the records in the studentList and the count of the deletedStudents
**/    
    
    global void execute(Database.BatchableContext context, List<Student__c> studentList){
        List<Student__c> studentsToUpdate = new List<Student__c>();
        
        for(Student__c student : studentList){
            if(student.Registration_Completed__c == false){
                student.Mark_Delete__c = 'Yes';
                studentsToUpdate.add(student);
                this.deletedStudentCount++;
            }
        }
        
        if(!studentsToUpdate.isEmpty()){
            update studentsToUpdate;
        }
        
        // Move these lines inside the execute method
        List<String> toAddresses = getEmailAddressesByCreatedById(studentList);
        if (!toAddresses.isEmpty()) {
            sendEmail(deletedStudentCount, toAddresses);
        }
    }
    
/**
description: this method retrieves the unique email addresses of the creators.
params : Database.BatchableContext context
returns : Returns the Id and emails of the creator.
**/
    
    global void finish(Database.BatchableContext context){
        // The finish method remains unchanged
        sendEmail(deletedStudentCount, new List<String>());
    }
    
    private static List<String> getEmailAddressesByCreatedById(List<Student__c> students) {
        Set<Id> createdByIds = new Set<Id>();
        List<String> toAddresses = new List<String>();
        
        for (Student__c student : students) {
            createdByIds.add(student.CreatedById);
        }
        
        for (User user : [SELECT Id, Email FROM User WHERE Id IN :createdByIds]){
            toAddresses.add(user.Email);
        }
        
        return toAddresses;
    }
    
    
/**
description: this method helps in sending the email to the creator with the help of pre-defined class.
params :Integer deletedCount, List<String>toAddresses
returns : Returns the records fetched by the query
**/
    
    private static void sendEmail(Integer deletedCount, List<String> toAddresses){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(toAddresses);
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('Hey, the batch Job Completed. Number of students marked for deletion: ' + deletedCount);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
/**
description: this is the method of the schedule class which schedules the Batch class
params :SchedulableContext sc
returns : Returns the records executed in batches.
**/
     global void execute(SchedulableContext sc){
        
        DeleteStudentRecordsBatch lub = new DeleteStudentRecordsBatch();
        Database.executeBatch(lub, 20);
        
        
    }
}