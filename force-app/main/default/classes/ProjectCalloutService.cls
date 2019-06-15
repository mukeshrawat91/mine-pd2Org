public class ProjectCalloutService {
    
    //method to be invoked by ProcessBuilder apex
    @InvocableMethod
    public static void postOpportunityToPMS(List<Id> oppoIds){
        Opportunity opportunity = [SELECT Id,Name,Account.Name,CloseDate,Amount FROM Opportunity WHERE Id = :oppoIds[0]];
        String serviceToken = ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
        
			wrapperclass wrap = new wrapperclass();
			wrap.opportunityId = opportunity.Id;
			wrap.opportunityName = opportunity.Name;
			wrap.accountName = opportunity.Account.Name;
			wrap.closeDate = String.ValueOf(opportunity.CloseDate).mid(0,10);
			wrap.amount = opportunity.Amount;
			
			String finalJSONinput = JSON.Serialize(wrap);
			
		System.enqueueJob(new QueueablePMSCall(serviceToken, finalJSONinput, opportunity.Id));
    }
    
    // future method to make apex callout
    @Future(callout=true)
    private static void postToPMS(String serviceToken, String jsonInput, Id oppoId) {
            HTTPRequest req = new HTTPRequest();
            req.setEndPoint('callout:ProjectService');
            req.setMethod('POST');
            req.setHeader('token',serviceToken);
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');        
            req.setBody(jsonInput);
            HTTP http = new HTTP();
            HTTPResponse res = http.send(req);
            Opportunity opp = new Opportunity(Id=oppoId);
        	if(res.getStatusCode() != 201){
                opp.StageName = 'Resubmit Project';
                System.debug('Failure: ' + res.getStatusCode() + ' ' + res.getStatus());
            } else {
                opp.StageName = 'Submitted Project';                
                System.debug('Success: ' + res.getStatus());
            }
            update opp;
    }
    
    //queueable class to enque the post request
    class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts {
        private String serviceToken;
        private String jsonInput;
        private String Id;
        public QueueablePMSCall(String serviceToken, String jsonInput, Id oppoId){
            this.serviceToken = serviceToken;
            this.jsonInput = jsonInput;
            this.Id = oppoId;
        }
        public void execute(QueueableContext context) {
            postToPMS(serviceToken, jsonInput, Id);
        }
    }
	
	public class wrapperclass {
        public String opportunityId;
        public String opportunityName;
        public String accountName;
		public String closeDate;
        public Decimal amount;
        
        
    }
    
}