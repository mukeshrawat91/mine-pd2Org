public class CampingListController {
	@AuraEnabled
    public static List<Camping_Item__c> getItems(){
        List<Camping_Item__c> toSendCampList = new List<Camping_Item__c>();
		toSendCampList = [SELECT id,Name,Quantity__c,Price__c,Packed__c FROM Camping_Item__c];
        return toSendCampList;
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c camptoload){
        database.insert(camptoload);
        return camptoload;
    }
    
}