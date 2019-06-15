trigger ProjectTrigger on Project__c (after update) {
    for( Id projectNew : Trigger.newMap.keySet() )
    {
          if( Trigger.oldMap.get( projectNew ).Status__c != Trigger.newMap.get( projectNew ).Status__c 
             && 'Billable' == Trigger.newMap.get( projectNew ).Status__c )
          {
              BillingCalloutService.callBillingService( Trigger.newMap.get( projectNew ).ProjectRef__c,
                                                       Trigger.newMap.get( projectNew ).Billable_Amount__c);
          }
    }
}