({
    onSearch : function(component,param1) {
        //alert("got the final id to search  " +param1);
        var action = component.get("c.getBoats");
        var btid = component.get("v.boatTypeId");
        //alert("boatTypeId  " + btid);
        action.setParams({
            "boatTypeId": param1
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("inside success of apex method");
                var temp = response.getReturnValue();
                console.log("all boat records  " +temp);
                //alert(JSON.parse(JSON.stringify(temp)));
                component.set("v.boats", temp);
            }
        });
        $A.enqueueAction(action); 
    }
})