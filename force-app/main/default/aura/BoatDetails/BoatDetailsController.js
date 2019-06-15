({
    onBoatSelected : function(component, event, helper) {
        var boatIdtopass =  event.getParam("boat");
        alert("inside the boatDetails Controller  " +boatIdtopass.Id);
        component.set("v.id",boatIdtopass.Id);
        //component.set("v.boat", boatIdtopass);
        //component.find("service").reloadRecord() ;
        var tempRec = component.find("service");
        tempRec.set("v.recordId", boatIdtopass.Id);
        tempRec.reloadRecord();
    },
    onBoatReviewAdded : function(component, event, helper) {
        console.log("Event received");
        component.set("v.selectedTabId", "boatreviewtab");
        //var compTorefresh =  component.get("v.toreviewBoat");
        //compTorefresh.refresh();
    },
    onRecordUpdated : function(component, event, helper) {
        var compTorefresh =  component.get("v.toreviewBoat");
        //compTorefresh.refresh();
    }
})