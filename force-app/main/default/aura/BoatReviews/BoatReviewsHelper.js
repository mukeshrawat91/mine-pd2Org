({
    onInit : function() {
        var action = component.get("c.getAll");
        var temp = component.get("v.boat");
        action.setParams({
            "boatId": temp.id
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var tempval = response.getReturnValue();
                if(tempval != 'null'){
                    component.set("v.boatReviews",tempval);
                    component.set("v.toshow",true);
                    //alert("Created the new Boat Type");    
                }else{
                    component.set("v.toshow",false);
                }
                
            }
        });
        $A.enqueueAction(action);  
    }
})