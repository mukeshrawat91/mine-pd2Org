global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
         List<Lead> fnl = new List<Lead>();
        List<Lead> opptys = [SELECT Id, Name,LeadSource  FROM Lead WHERE LeadSource  = '' LIMIT 200];
        for(Lead ld : opptys){
            ld.LeadSource = 'Dreamforce';
            fnl.add(ld);
        }
        update fnl;
        
    }
    
}