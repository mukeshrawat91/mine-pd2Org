({
    doSearch : function(component, event, helper) {
        var params = event.getParam("arguments");
        if (params) {
            var param1 = params.boatTypeId;
            alert("param to get " +param1);
            //component.set("v.boatTypeId", param1);
            alert("final param key to search " +param1);
			helper.onSearch(component,param1);
        }
    },
    
    onBoatSelect : function(component, event, helper) {
        component.set("v.selectedBoatId",event.getParam("boatId"));
    }
})