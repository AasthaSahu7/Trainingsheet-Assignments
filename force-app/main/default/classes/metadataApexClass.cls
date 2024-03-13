public class metadataApexClass {
//method to fetch all the sobjects dynamically
    @AuraEnabled
    public static List<String> getObject(){
        List<String> objects = new List<String>();
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        for(Schema.SObjectType sobj : gd){
            objects.add(sobj.getDescribe().getName());
        }
        objects.sort();
        System.debug(objects);
        return objects;
    }
    
}