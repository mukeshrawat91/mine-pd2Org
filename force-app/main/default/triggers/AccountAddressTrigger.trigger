trigger AccountAddressTrigger on Account (before insert,before update) {
    List<Account> acct = new List<Account>();
    for(Account a : Trigger.new){
        if(a.Match_Billing_Address__c){
            a.ShippingPostalCode = a.BillingPostalCode;
            //acct.add(a);
        }
    }
    //Database.update(acct);
}