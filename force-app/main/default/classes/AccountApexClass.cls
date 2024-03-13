public with sharing class AccountApexClass {
  @AuraEnabled 
  public static List<Account> getAccounts(){
  List<Account> accList = [SELECT Id, Name FROM Account];
   return accList;
    //System.debug(accList);
    }
    
    @AuraEnabled
    public static List<Contact> getContacts(String selectedAccountId){
    List<Contact> conList = [SELECT Id, Name, Email,AccountId FROM Contact where AccountId =: selectedAccountId];
        return conList;
    }
}