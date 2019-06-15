public class BillingCalloutService {
    
    @future(callout=true)
    public static void callBillingService(String projectRef, Decimal billingAmount){
        
        ServiceCredentials__c servCred = ServiceCredentials__c.getValues('BillingServiceCredential');
        
        BillingServiceProxy.project project = new BillingServiceProxy.project();
        project.username = servCred.Username__c;
        project.password = servCred.Password__c;
        project.projectRef = projectRef;
        project.billAmount = billingAmount;
        
        BillingServiceProxy.InvoicesPortSoap11 invoiceCall = new BillingServiceProxy.InvoicesPortSoap11();
        String response = invoiceCall.billProject(project);
        
        List<Project__c> proj;
        if (response != null && response.equalsIgnoreCase('OK')){
            proj = [SELECT Status__c FROM Project__c WHERE ProjectRef__c =: projectRef];
            if(proj.size() > 0){
                proj[0].Status__c = 'Billed';
            }
            update proj;
        }
        
        
    }
}