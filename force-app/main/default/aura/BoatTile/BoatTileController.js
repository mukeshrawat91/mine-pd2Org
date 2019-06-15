({
    onBoatClick : function(component, event, helper) {
        var ev = component.getEvent("boatclkevent");
        var btId = component.get("v.boat");
        ev.setParams({"boatId" : btId.Id});
        ev.fire();
        
        //var ev = component.getEvent("boatTileselected");
        var selbtid = component.get("v.boat");
        alert("We are firing events to display Boat Details " +selbtid.Id);
        var appEvent = $A.get("e.c:BoatSelected");
        appEvent.setParams({
            "boat": selbtid
        });
        appEvent.fire();      
        
        
        var plotmap = component.get("v.boat");
        var createEvent = $A.get("e.c:PlotMapMarker");
        createEvent.setParams({'sObjectId' : plotmap.id});
        createEvent.fire();
        
    }
})