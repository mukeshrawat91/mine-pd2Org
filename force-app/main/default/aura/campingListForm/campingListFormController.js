({
    clickCreateItem : function(component, event, helper) {
        var validExpense = component.find('expenseform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validExpense){
            
            
            // Create the new expense
            var newExpense = component.get("v.newItem");
            helper.createItem(component,newExpense);
            console.log("Create expense: " + JSON.stringify(newExpense));
            //helper.createExpense(component, newExpense);
            
            var theExpenses = component.get("v.items");
            
            // Copy the expense to a new object
            // THIS IS A DISGUSTING, TEMPORARY HACK
            var newExpense1 = JSON.parse(JSON.stringify(newExpense));
            
            theExpenses.push(newExpense1);
            component.set("v.items", theExpenses);
            component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                            'Name': '',
                            'Quantity__c': 0,
                            'Price__c': 0,
                            'Packed__c': false});
            //component.set("v.newItem", theExpenses);
            
            
        }
    },
    
    doInit : function(component, event, helper) {
        var allItemToload = component.get("c.getItems");
        component.set("v.items",allItemToload);
    }   
})