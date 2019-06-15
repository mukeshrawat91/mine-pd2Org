({
    createItem : function(component, itemtoload) {
        var createEvent = component.getEvent("addItem");
        createEvent.setParams({ "item": itemtoload });
        createEvent.fire();
        component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                                   'Name': '',
                                   'Quantity__c': 0,
                                   'Price__c': 0,
                                   'Packed__c': false});
        var action = component.get("c.saveItem");
        action.setParams({
            "camptoload": itemtoload
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var expenses = component.get("v.items");
                expenses.push(response.getReturnValue());
                component.set("v.items", expenses);
            }
        });
        $A.enqueueAction(action);
    }
})