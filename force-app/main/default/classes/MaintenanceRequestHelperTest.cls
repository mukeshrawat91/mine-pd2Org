@isTest
private class MaintenanceRequestHelperTest {
		
	//Leverage a @testSetup method to reduce execution time and increase maintainability
	@testSetup
	static void allTheDataForThisTestClass() {

		// Principle #1: Create records from scratch!
		// Remember that Records created in a test setup method are rolled back at the end of test class execution. 
		// Test setup methods enable you to create common test data easily and efficiently. 
		// By setting up records once for the class, you don’t need to re-create records for each test method.

		Account acc = new Account();
		acc.Name = 'test';
		insert acc;

	        Contact contact = new Contact();
	        contact.FirstName = 'test';
	        contact.LastName = 'last';
	        contact.Email = 'test@test.com';
	        contact.AccountId = acc.Id;
	        insert contact;

	        // This is a Custom Object
	        Vehicle__c vehicle = new Vehicle__c();
	        vehicle.Name = 'car';
	        insert vehicle;

	        Product2 product = new Product2();
	        product.Name = 'test';
	        product.isActive = true;
	        product.Maintenance_Cycle__c = 2;
	        product.Replacement_Part__c = true;
	        insert product;
	}
		
       static testMethod void test_triggerMaintenanceRequestHelperTest() {
    	// Principle #2: Test the class for as much user Profiles as necessary. 
    	//               Here we're going to use an Standard User. 
    	//               Also, please consider using some Global Static variables to store the test user info.
    	
    	// This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'stdtest', Email='stdtest@testorg.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='stdtest@testorg.com');

        System.runAs(u) {
        	
        	List<Case> caseList = new List<Case>();
            List<Case> secondList = new List<Case>();
            
            //grab the data that was created in the allTheDataForThisTestClass method
            Account acc = [SELECT Id, Name FROM Account WHERE Name = 'test' LIMIT 1]; 
            Contact contact  = [SELECT Id, FirstName, LastName,Email,AccountId FROM Contact WHERE Email = 'test@test.com' LIMIT 1]; 
            Vehicle__c vehicle = [SELECT Id, Name FROM Vehicle__c WHERE Name = 'car' LIMIT 1]; 
            Product2 product = [SELECT Id, Name, isActive, Maintenance_Cycle__c, Replacement_Part__c FROM Product2 WHERE Name = 'test' LIMIT 1]; 
            
            // "Setup" data has been entered, begin testing
            // This trick gives us a new set of Governor Limits!
            Test.startTest();
            
            // Test in bulk (200+ records)!
            for(Integer i=1;i<=1000;i++){
                Case maintenanceNew             = new Case();
                maintenanceNew.Subject          = 'Other';
                maintenanceNew.Vehicle__c       = vehicle.Id;
                maintenanceNew.Product__c       = product.Id;
                maintenanceNew.ContactId        = contact.Id;
                maintenanceNew.AccountId        = acc.Id;
                maintenanceNew.Type             = 'Other';
                maintenanceNew.Status           = 'New';
                maintenanceNew.Equipment__c     = product.Id;
                maintenanceNew.Date_Reported__c = Date.today();
                maintenanceNew.Date_Due__c      = Date.today();

                caseList.add(maintenanceNew);   
            }

            insert caseList;
            
            // Assert your results!
            System.assertEquals(1000,caseList.size());
            
            //Now you can validate the Repair/Closed cases.
            for(Case cas:caseList){
                //update information
                cas.Type = 'Repair';
                cas.Status = 'Closed';
                secondList.add(cas);
            }

            update secondList;
            List<Case> createdCases = [Select Id from Case where Type = 'Routine Maintenance'];
            System.assertEquals(1000,createdCases.size());
            
            //Remember to stop the test.
            Test.stopTest();
            
            // Please remember to test things that shouldn't work!
            // Example: If you deleted records, create a query trying to find the records.
            // Then use the System.assertEquals(0,ShouldBeDeletedCases.size()); or something similar.
        }
    }   
}