public class BoatReviews {
	@AuraEnabled
    public static List<BoatReview__c> getAll(Id boatId){
        List<BoatReview__c> toSendCampList = new List<BoatReview__c>();
        toSendCampList = [SELECT Id, Name,Comment__c, Rating__c,CreatedDate,LastModifiedDate,CreatedBy.Name,
                          CreatedBy.SmallPhotoUrl,CreatedBy.CompanyName FROM BoatReview__c where id=:boatId];
       
        return toSendCampList;
    }
}