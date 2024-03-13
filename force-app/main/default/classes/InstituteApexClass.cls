public with sharing class InstituteApexClass {
  @AuraEnabled 
  public static List<Institute2__c> getInstitutes(){
  List<Institute2__c> instList = [SELECT Name FROM Institute2__c];
   return instList;
    //System.debug(instList);
    }
}