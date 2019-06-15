@isTest
public class OrderExtension_UnitTest {
	@isTest
    private static void OrderExtension_UnitTest() {
        Test.startTest();
        
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        Test.setCurrentPage(Page.OrderEdit);
        ApexPages.StandardController sc = new ApexPages.StandardController(new Order());
        OrderExtension ext = new OrderExtension(sc);
        ext.orderRecord.AccountId = acc.Id;
        ext.orderRecord.EffectiveDate = System.Today();
        ext.orderRecord.Status = Constants.DRAFT_ORDER_STATUS;
		
        ext.orderItemList[0].Quantity = 1;
        ext.orderItemList[0].UnitPrice = 1;
        ext.orderItemList[1].Quantity = 2;
        ext.orderItemList[1].UnitPrice = 2;
        ext.orderItemList[2].Quantity = 3;
        ext.orderItemList[2].UnitPrice = 3;

        ext.OnFieldChange();
        System.assertEquals(14.0 ,ext.total);
        
        //ext.updateOrderItemMap();
		System.assertEquals(3, ext.orderItemMap.size());
        
        ext.orderItemList[2].Quantity = 0;
        //ext.updateOrderItemMap();
		
        ext.orderItemList.clear();
        //ext.updateOrderItems();        
				
        ext.OnFieldChange();
        System.assertEquals(5, ext.total);
        
        ext.save();
        
        List<Order> savedOrdersList = [select Id, Name, (SELECT Quantity, UnitPrice FROM OrderItems) from Order where accountId=:acc.Id];
		System.assertEquals(1, savedOrdersList.size());
        System.assertEquals(2, savedOrdersList[0].OrderItems.size());
        
        System.currentPageReference().getParameters().put('Id', savedOrdersList[0].Id);
        sc = new ApexPages.StandardController(savedOrdersList[0]);
        ext = new OrderExtension(sc);
		
        ext.orderItemList[1].Quantity = 0;
        ext.orderItemList[3].Quantity = 5;
        ext.orderItemList[3].UnitPrice = 2;
        ext.orderItemList[4].Quantity = 1;
        ext.orderItemList[4].unitPrice = 2;
        
		ext.save();
        
        savedOrdersList = [select Id, Name, (SELECT Quantity, UnitPrice FROM OrderItems) from Order where accountId=:acc.Id];
		System.assertEquals(1, savedOrdersList.size());
        System.assertEquals(3, savedOrdersList[0].OrderItems.size());
        
        ext.selectedFamily = 'Dessert';
        ext.SelectFamily();
        
        ext.selectedFamily = Constants.SELECT_ONE;
        ext.SelectFamily();
        
		ext.first();
        ext.next();
        ext.previous();
        ext.last();
        Boolean hasPrevious = ext.GetHasPrevious();
        System.assertEquals(true, hasPrevious);
        Boolean hasNext = ext.GetHasNext();
        System.assertEquals(false, hasNext);
        
        ext.GetTotalPages();
        ext.GetPageNumber();
        
        ext.GetFamilyOptions();
        
        Test.stopTest();

    }
}