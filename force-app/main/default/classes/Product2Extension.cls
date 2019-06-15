public class Product2Extension {

    //public List<Product2> productsToInsert {get;set;}
    public list<ProductWrapper> productsToInsert                   {get;set;}
    public String ErrorMessage                                     {get;set;}
    public Boolean ShowError                                       {get;set;}
    public list<SelectOption> FamilyOptions{get;set;}
    public class ProductWrapper
    {
               public Product2 productRecord                          {get;set;}
               public PriceBookEntry pricebookEntryRecord             {get;set;}
               public String familyValue                              {get;set;}
               public list<SelectOption> FamilyOptions               {get;set;}
        public Integer unitPrice {get;set;}
               public ProductWrapper(Product2 P, PriceBookEntry Pbe, list<SelectOption> family)
               {
                   this.productRecord=P;
                   this.pricebookEntryRecord=Pbe;
                   this.pricebookEntryRecord.Pricebook2Id=Constants.STANDARD_PRICEBOOK_ID;
                   this.FamilyOptions=family;
                //system.debug('options-->' +this.familyPickList);
                   //GetFamilyOptions(this.familyPickList);
               }
    }
    
    public Product2Extension(Apexpages.StandardController stdCon)
    {
            productsToInsert = new List<ProductWrapper>();
            addRows();
       // system.debug('options--> ' +productsToInsert[0].familyPickList);
    }

    public void AddRows()
    {
            for (Integer i=0; i<Constants.DEFAULT_ROWS; i++)
            {
                Product2 P=new Product2();
                PriceBookEntry Pbe=new PriceBookEntry();
                system.debug('### product and price book '+P+' '+Pbe);
                
                if(P==null)
                 system.debug('### product is null');
                 
                List<SelectOption> Family=getFamilyOptions();
                productsToInsert.add(new ProductWrapper(P,Pbe,Family));
                // productsToInsert.add( new Product2() );
            }
    }
    
    public List<SelectOption> getFamilyOptions() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(Constants.SELECT_ONE,Constants.SELECT_ONE));
        for(Schema.PicklistEntry p : Constants.PRODUCT_FAMILY)
        {
            options.add(new SelectOption(p.getValue(), p.getValue()));
        }
        
        return options;
    }
    
    public List<ChartHelper.ChartData> GetInventory()
    {
            return ChartHelper.GetInventory();
    }

    public PageReference Save(){
        Savepoint sp = Database.setSavepoint();
        try {
            List<Product2> products = new List<Product2>();
            List<PricebookEntry> entries = new List<PricebookEntry>();
            
            for (ProductWrapper wrp : productsToInsert){
                if(null!=wrp.productRecord && null!=wrp.pricebookEntryRecord){
                    
                    if(null!=wrp.productRecord.Name && null!=wrp.productRecord.Family && constants.SELECT_ONE!=wrp.productRecord.Family
                       && null!=wrp.productRecord.Initial_Inventory__c && null!=wrp.pricebookEntryRecord.UnitPrice){
                        products.add(wrp.productRecord);
                        PricebookEntry entry=wrp.pricebookEntryRecord;
                        entry.IsActive=true;
                        entry.Pricebook2Id=constants.STANDARD_PRICEBOOK_ID;
                        entries.add(entry);   
                    }
                }
            }
                                                
            insert products;
            
            for (integer itr=0; itr<entries.size();itr++){
                entries[itr].Product2Id=products[itr].id;
            }
            insert entries;
            //If successful clear the list and display an informational message
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,productsToInsert.size()+' Inserted'));
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){
                                                Database.rollback(sp);
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,constants.ERROR_MESSAGE));
        }
        return null;
    }
}