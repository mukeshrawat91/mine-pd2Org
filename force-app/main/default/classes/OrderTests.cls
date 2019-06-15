@isTest (SeeAllData=false)
private class OrderTests {
    public static Map<String, List<Object>> returnMap ;
   @testSetup
    static void SetupTestData() {
                    returnMap =  TestDataFactory.InsertTestData(5);
    }

    @isTest static void OrderExtension_UnitTest() {
        PageReference pageRef = Page.OrderEdit;
        Test.setCurrentPage(pageRef);
        SetupTestData();
        List<order> orderList = (List<order>)returnMap.get('orders');
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(orderList[0]);        
        OrderExtension ext = new OrderExtension(stdcontroller);        
               System.assertEquals(Constants.DEFAULT_ROWS, ext.orderItemList.size());
        ext.OnFieldChange();
        ext.SelectFamily();
        ext.Save();
        ext.First();
        ext.Next();
        ext.Previous();
        ext.Last();
        ext.GetHasPrevious();
        ext.GetHasNext();
        ext.GetTotalPages();
        ext.GetPageNumber();
        List<SelectOption> options = ext.GetFamilyOptions();
    }
    
@isTest
public static void OrderUpdate_UnitTest(){
    setupTestData();
    
   
    Test.startTest();
    
    List<Order> orders = (List<order>)returnMap.get('orders');
    for (Order o : orders){
        o.Status = Constants.ACTIVATED_ORDER_STATUS;
    }
    List<Product2> oldProducts = (List<Product2>)returnMap.get('products');
    Set<Id> productIds = new Set<Id>();
    for (Product2 oldProd : oldProducts){
        productIds.add(oldProd.Id);
    }
    oldProducts = [SELECT Id, Quantity_Ordered__c FROM Product2 WHERE ID IN :productIds];
    Map<Id, Integer> quantities = new Map<Id, Integer>();
    for (OrderItem oi : (List<OrderItem>)returnMap.get('orderitems')){
        Integer quantity = 0;
        List<PricebookEntry> pricebookentries = (List<PricebookEntry>)returnMap.get('pricebookentries');
        for (PricebookEntry pbe : pricebookentries){
            if (oi.PricebookEntryId == pbe.Id){                
                if (quantities.containsKey(pbe.Product2Id)){
                    quantity = quantities.get(pbe.Product2Id);
                }
                quantity += (Integer)oi.Quantity;
                quantities.put(pbe.Product2Id, quantity);
                break;
            }
        }
    }
   
    update orders;
    Map<Id, Product2> currentProducts = new Map<Id, Product2>([Select Id, Quantity_Ordered__c FROM Product2 WHERE Id IN :productIds]);
  
    for (Product2 prod : oldProducts){
      
        TestDataFactory.VerifyQuantityOrdered(prod, currentProducts.get(prod.Id), quantities.get(prod.Id));
  }
  Test.stopTest();
}
}