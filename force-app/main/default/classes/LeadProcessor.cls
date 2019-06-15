global class LeadProcessor implements 
Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        List<Lead> ld = new List<Lead>();
        for (Lead ldone : scope) {
            ldone.LeadSource = 'Dreamforce';
            ld.add(ldone);
        }
        update ld;
        
    }
    
    
    global void finish(Database.BatchableContext bc){
        
    }    
    
}