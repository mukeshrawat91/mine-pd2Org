({
    
    onFullDetails : function (component, event, helper) {
        var boatrec  = component.get("v.boat");
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": boatrec.Id
            
        });
        navEvt.fire();
    }
})