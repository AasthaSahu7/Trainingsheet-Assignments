global class MarkStudentRecordsBatch implements Database.Batchable<sObject>, Schedulable
{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Mark_For_Delete__c, Is_Registeration_Completed__c from Student__c 
                                       ]);
    }
    
    global void execute(Database.BatchableContext bc, List<Student__c> studList){
        for(Student__c stud : studList)
        { 
            if( stud.Is_Registeration_Completed__c == 'False'){
            stud.Mark_For_Delete__c = 'YES';
           // studList.add(stud); 
            }   
        }
        update studList;
    }
    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new  Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{'aasthasahu07@gmail.com'};
            mail.setToAddresses(toAddress);
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('Hey, the batch job that you started is completed.');
        Messaging.sendEmail(new  Messaging.SingleEmailMessage[]{mail});
        
    }
    global void execute(SchedulableContext sc){
       MarkStudentRecordsBatch  msb = new MarkStudentRecordsBatch();
         Database.executeBatch(msb);
        
    }
}