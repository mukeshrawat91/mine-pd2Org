public class BoatSearchResults {
    @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId) {
        if(boatTypeId != '')  {
            return [SELECT id, BoatType__c, picture__c, name,contact__r.Name
                    FROM Boat__c
                    WHERE BoatType__c =:boatTypeId];
        } else {
            return [SELECT id, BoatType__c, picture__c, name,contact__r.Name
                    FROM Boat__c];
        }
    }
   
    @AuraEnabled
    public static List<BoatType__c> getBoatTypes()
    {
        return [SELECT Id, Name from BoatType__c ORDER BY Name];
    }
}