public class DataTableController {
    @AuraEnabled
    public static List<Account> getDynamicData() {
        return [SELECT Id, Name, AccountNumber FROM Account LIMIT 10];
        // Query your object fields dynamically based on your requirement
    }
}