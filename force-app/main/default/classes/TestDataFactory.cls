/**
* @name TestDataFactory
* @description Contains methods to construct and/or validate commonly used records
**/
public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static CollaborationGroup ConstructCollaborationGroup(){
        //ToDo: Ensure this method returns a single Chatter CollaborationGroup
        //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
        //    and configured so anyone can join, see and post updates.
        CollaborationGroup myGroup = new CollaborationGroup();
        String name = String.valueOf(System.now());
        String tt = name.substring(0,3);
        
        myGroup.Name='Test'+ Constants.INVENTORY_ANNOUNCEMENTS;
        myGroup.CollaborationType='Public'; //can be 'Public' or 'Private'                   
        return myGroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public  static list<product2> ConstructProducts(Integer cnt){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
  
                                List<Product2> prods = new List<Product2>();
        
        for(integer i=0;i< cnt;i++)
        {
           Product2 prod = new Product2();
           prod.Name = 'test ' + I ;
            prod.isActive = true;
            prod.Initial_Inventory__c = 10;
            if(i >= 4 )
                               prod.Family = constants.PRODUCT_FAMILY[0].getValue();
            else
               prod.Family = constants.PRODUCT_FAMILY[i].getValue(); 
             prods.add(prod); 
            }
           
        
        
        return prods;   

    }
    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PriceBookEntry> ConstructPricebookEntries(List<Product2> prods){
        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
        List<PriceBookEntry> listPBE=new List<PriceBookEntry>();
        for(Product2 p: prods)
        {
            PriceBookEntry pbe=new PriceBookEntry();
            pbe.isActive=true;
            pbe.Pricebook2Id=Constants.STANDARD_PRICEBOOK_ID; 
            pbe.Product2Id=p.Id;
            pbe.UnitPrice=10;
            listPBE.add(pbe);
        }
        return listPBE;
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
        //  with all of the required fields populated.
        List<Account> listAcc=new List<Account>();
        for(Integer n=0;n<cnt;n++)
        {
            Account a=new Account();
            a.Name='TEST1_'+n;
            listAcc.add(a);
        }
        
        return listAcc;
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
         List<Contact> listCC=new List<Contact>();
     
        for(Integer n=0;n<cnt;n++)
        {
            Contact c=new Contact();
            c.LastName='LN1_'+n;
            c.AccountId=accts[n].Id;
            listCC.add(c);
            
        }
        
        return listCC;
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.

   List<Order> listOrd=new List<Order>();
       
        
        for(Integer n=0;n<cnt;n++)
        {
            Order o=new Order();
            o.EffectiveDate=System.today();
            o.AccountId=accts[n].Id;
            o.Status='Draft';
            //o.Pricebook2Id= Constants.getStdPricebookId();
            o.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
            listOrd.add(o);
           
        }
        
        return listOrd;

        
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
        
        List<OrderItem> listOi=new List<OrderItem>();
      
        for(Integer n=0; n<cnt;n++)
        {
            OrderItem oi=new OrderItem();
            oi.OrderId=ords[n].Id;
            oi.PricebookEntryId=pbes[n].id;
            oi.UnitPrice=pbes[n].UnitPrice;
            oi.Quantity=Constants.DEFAULT_ROWS;
           
            
            listOi.add(oi);
        }
        
        return listOi;
    }
    
    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered)
    {
     
       System.assertEquals(
            originalProduct.Quantity_Ordered__c + qtyOrdered,
            updatedProduct.Quantity_Ordered__c,
            'error on Quantity_Ordered__c update'
            );
     
        
    }

                public List<Order> o = new List<Order>();
    public static final String NEW_GROUP_NAME = 'Test'+ Constants.INVENTORY_ANNOUNCEMENTS;
    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static Map<String, List<Object>> InsertTestData(Integer cnt){
        //ToDo: Ensure this method calls each of the construct methods
        //  and inserts the results for use as test data.
    
       
        List<CollaborationGroup> candidates = [SELECT Id FROM CollaborationGroup WHERE Name = :NEW_GROUP_NAME];
        if (!candidates.isEmpty()) {
        }
        else
        {
            // only create the group if it's missing
            CollaborationGroup colG=ConstructCollaborationGroup();
            insert colG;
            
        }
        
        
       List<Account> a=ConstructAccounts(cnt);
        insert a;
        
       List<Contact> c=ConstructContacts(cnt, a);
        insert c;
        
       List<Product2> p= ConstructProducts(cnt);
        insert p;
        
        List<PriceBookEntry> pbe=ConstructPricebookEntries(p);
        insert pbe;
       
        List<Order> o=ConstructOrders(cnt, a);
        insert o;
       
       
       List<OrderItem> oi=ConstructOrderItems(cnt, pbe, o);
        insert oi;
        
        Map<String, List<Object>> returnMap = new Map<String, List<Object>>();
        returnMap.put('accounts', a);
        returnMap.put('contacts', c);
        returnMap.put('products', p);
        returnMap.put('pricebookentries', pbe);
        returnMap.put('orders', o);
        returnMap.put('orderitems', oi);
        
        return returnMap;
    }

}