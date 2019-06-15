@isTest
private class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> accounts = new List<Lead>();
       // List<Contact> contacts = new List<Contact>();
        // insert 10 accounts
        for (Integer i=0;i<10;i++) {
            accounts.add(new Lead(LeadSource='Dreamforce',LastName='lastname', Company='cmpny'));
        }
        insert accounts;
        
    }

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor uca = new LeadProcessor();
        Id batchId = Database.executeBatch(uca);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals('Dreamforce', [select id,name,LeadSource from Lead LIMIT 1].LeadSource);
    }
    
}