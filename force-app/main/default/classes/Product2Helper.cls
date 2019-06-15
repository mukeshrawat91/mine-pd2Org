public class Product2Helper {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name = :constants.INVENTORY_ANNOUNCEMENTS 
        OR Name = :('TEST'+constants.INVENTORY_ANNOUNCEMENTS )
        LIMIT 1
    ];

    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<product2> prodlist){
        //ToDo: Declare a List of Product2 records named needsAnnouncement

        //ToDo: Declare a Map of Strings to Inventory_Setting__mdt records

        //ToDo: Loop through a query of Inventory_Setting__mdt records and populate the Map with Name as the key

        //ToDo: Loop through the Products in newList
        // Use the corresponding Inventory Setting record to determine the correct Low Quantity Alert
        // If the Product's Quantity Remaining has been changed to less than the Low Quantity Alert
        //      add it to the needsAnnouncement list

        //ToDo: Pass records to the postAlerts method
        PostAlerts(prodlist);
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
        List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        
        for ( Product2 p : productList ){
            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
            ConnectApi.AnnouncementInput announcement = new ConnectApi.AnnouncementInput();
            announcement.parentId = COLLABORATION_GROUP[0].Id;
            announcement.expirationDate = Date.today().addDays(1);
            announcement.sendEmails = false;
            
            textSegmentInput.text = p.Name + ' ' + Constants.INVENTORY_LEVEL_LOW;
            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
            messageBodyInput.messageSegments.add(textSegmentInput);
            announcement.body = messageBodyInput;
            toPost.add(announcement);
        }
        
        AnnouncementQueueable q = new AnnouncementQueueable(toPost);
        System.enqueueJob(q);
    }
}