global class LeadUpdateBatch implements Database.Batchable<sObject>, Schedulable
{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select AnnualRevenue from Lead]);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> lList){
        for(Lead l : lList)
        {
            if(l.AnnualRevenue == null){
                l.AnnualRevenue = 2000000;  
            }
        }
        update lList;
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
        LeadUpdateBatch lub = new LeadUpdateBatch();
        Database.executeBatch(lub, 200);
        
    }
}