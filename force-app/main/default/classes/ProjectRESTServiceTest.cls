@isTest
private class ProjectRESTServiceTest {
/*
    public static testMethod void testSuccess(){
        // Not using bulk because REST call doesn't support BULK
        // Not using Running User because this is a DE org and only supports 2 users
        
        // Create Test Account
        Account acct = new Account(Name='Test Account');
        insert acct;
        
        // Create Test Opportunity
        LIST<Opportunity> oppLIST = new LIST<Opportunity>();
        oppLIST.add(new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acct.id, 
            CloseDate = System.Today(),            
            Amount = 12480.00,
            Type = 'Submitted Project',
            StageName='Submitted Project'));
        insert oppLIST;
        
        // Start Test
        Test.startTest();
        
        // Process  test
        string strResponse = ProjectRESTService.postProjectData('testing1104', 'testing1104', 
            string.valueOf(oppLIST[0].ID), oppLIST[0].CloseDate, oppLIST[0].CloseDate, double.valueOf(oppLIST[0].Amount), 'Running');
        system.assertEquals('OK', strResponse);
        
        // Stop Test
        Test.stopTest();
        
        // Verify outcome
        Opportunity opp = [select ID, StageName from Opportunity where ID = :oppLIST[0].ID LIMIT 1][0];
        system.assertEquals('Submitted Project', opp.StageName);
    } // END testSuccess

    public static testMethod void testFailure(){
        // Not using bulk because REST call doesn't support BULK
        // Not using Running User because this is a DE org and only supports 2 users
        
        // Create Test Account
        Account acct = new Account(Name='Test Account');
        insert acct;
        
        // Create Test Opportunity
        LIST<Opportunity> oppLIST = new LIST<Opportunity>();
        oppLIST.add(new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acct.id, 
            CloseDate = System.Today(),            
            Amount = 12480.00,
            Type = 'New Project',
            StageName='Qualification'));
        insert oppLIST;
        
        // Start Test
        Test.startTest();
        
        // Process  test
        //ProjectRESTService.strSimulateError = 'CATCH';
        Project__c p = new Project__c(Opportunity__c = oppLIST[0].Id,Name='test');
        insert p;

        string strResponse = ProjectRESTService.postProjectData(p.ProjectRef__c, p.Name, 
            string.valueOf(oppLIST[0].ID), oppLIST[0].CloseDate, oppLIST[0].CloseDate,
                                                                double.valueOf(oppLIST[0].Amount), 'Running');
        
        // Stop Test
        Test.stopTest();
        
    } // END testFailure
*/
} // END ProjectRESTServiceTest