({
	onFormSubmit : function(component, event, helper) {
        var formData = event.getParam("formData");
        console.log("getting the formData " +formData);
        //var boatTypeId = formData.boatTypeId;
        //alert("getting the boat id " +boatTypeId);
        var childCmp = component.find("childCmp");
        //console.log("getting the boattypeId " +boatTypeId);
		var auraMethodResult = childCmp.search(formData);
        console.log("auraMethodResult: " + auraMethodResult);

	}
})