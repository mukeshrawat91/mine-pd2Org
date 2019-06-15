({
    onSave : function(component, event, helper) {
        var recordLoader = component.find("service");
        recordLoader.saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "ERROR") {
                var errMsg = JSON.stringify(saveResult.error);
                
                alert(errMsg);
                // saveResult.error is an array of errors,
                // so collect all errors into one message
                for (var i = 0; i < saveResult.error.length; i++) {
                    errMsg += saveResult.error[i].message + "\n";
                }
                component.set("v.recordError", errMsg);
            } else{
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Saved!!",
                    "message": "The record was Saved."
                });
                resultsToast.fire();
                
                alert("Record is Saved!!");
                
                
                var cmpEvent = $A.get("e.c.BoatReviewAdded");
                cmpEvent.fire();
                
                var boatReviewAddedEvent = component.getEvent("boatReviewAdded");
      			boatReviewAddedEvent.fire();
                
                
                //cmp.set("v.recordSaveError", "");
            }
        }));
        helper.onInit(component, event, helper);
    },
    
    onRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            // get the fields that changed for this record
            var changedFields = eventParams.changedFields;
            console.log('Fields that are changed: ' + JSON.stringify(changedFields));
            // record is changed, so refresh the component (or other component logic)
            var resultsToast = $A.get("e.force:showToast");
            resultsToast.setParams({
                "title": "Saved",
                "message": "The record was updated."
            });
            resultsToast.fire();
            
        } else if(eventParams.changeType === "LOADED") {
            // record is loaded in the cache
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted and removed from the cache
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving or deleting the record
        }
    },
    
    doInit : function(component, event, helper) {
        component.find("service").getNewRecord(
            "BoatReview__c", 
            null,       
            false,     
            $A.getCallback(function() {          
                var rec = component.get("v.boatReview");      
                var error = component.get("v.recordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                else {               
                    rec.Boat__c = component.get('v.boat').Id;
                    component.set('v.boatReview', rec);
                }                
            })
        );
    }
})