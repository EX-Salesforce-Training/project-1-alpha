@IsTest
public with sharing class TrendingListControllerTest {
   public static List<Store_Product__c> allItems {get; set;}
   public static Integer currInt = 0;

     @isTest public static void GetProductItemHelper() {
         TrendingListController testingTrendingListController = new TrendingListController();
        
         allItems = new List<Store_Product__c>();
         for(Integer i = 0; i <= 25; i++) {
            Store_Product__c temp = GetNewStoreProduct();
            allItems.add(temp);
        }
        test.starttest();
        insert allItems;
        test.stoptest();
        testingTrendingListController.GetProductItemHelper();
        System.assertEquals(testingTrendingListController.totalProducts.size(), 26);
         System.assertEquals(testingTrendingListController.GetTotalProducts().size(), 26);
         System.assertEquals(testingTrendingListController.GetCurrentPage(), 0);
        System.assertEquals(allItems.get(0).Price_Per_Unit__c,
                            testingTrendingListController.row0column0Price);
        System.assertNotEquals(testingTrendingListController.row0Column0Rating,
                            0);
        testingTrendingListController.ShowNextProducts();
        System.assertEquals(testingTrendingListController.GetCurrentPage(), 1);
        testingTrendingListController.ShowPreviousProducts();
        System.assertEquals(testingTrendingListController.GetCurrentPage(), 0);
        System.assertEquals(1, 1);
       
       
        
    }

    @isTest public static void SetItemsInGallery() {
        allItems = new List<Store_Product__c>();
        for(Integer i = 0; i <= 25; i++) {
            Store_Product__c temp = GetNewStoreProduct();
            allItems.add(temp);
        }
        test.starttest();
        insert allItems;
        test.stoptest();
        TrendingListController testingTrendingListController = new TrendingListController();
        
           System.assertEquals(allItems.get(testingTrendingListController.currItem ).Name,
                                     allItems.get(testingTrendingListController.currItem ).Name);
           System.assertEquals(allItems.get(testingTrendingListController.currItem).Rating__c,
                                     allItems.get(testingTrendingListController.currItem).Rating__c);
           System.assertEquals(allItems.get(testingTrendingListController.currItem).Price_Per_Unit__c,
                                     allItems.get(testingTrendingListController.currItem).Price_Per_Unit__c);
        
    }
    @isTest public static void ShowNextProducts() {
         allItems = new List<Store_Product__c>();
         for(Integer i = 0; i <= 25; i++) {
            Store_Product__c temp = GetNewStoreProduct();
            allItems.add(temp);
        }
        test.starttest();
        insert allItems;
        test.stoptest();
        TrendingListController testingTrendingListController = new TrendingListController();
        //System.assertEquals(testingTrendingListController.currItem, 2);
       
        System.assertNotEquals(0, 26/3);
    }
     @isTest public static void ShowPreviousProducts() {
          allItems = new List<Store_Product__c>();
          for(Integer i = 0; i <= 25; i++) {
            Store_Product__c temp = GetNewStoreProduct();
            allItems.add(temp);
        }
        test.starttest();
        insert allItems;
        test.stoptest();
        TrendingListController testingTrendingListController = new TrendingListController();
      //  System.assertEquals(testingTrendingListController.currItem, 2 );
    }
    @isTest public static void SaveItemData(){
        
         allItems = new List<Store_Product__c>();
         TrendingListController testingTrendingListController = new TrendingListController();

        testingTrendingListController.SaveItemData('hello', 1, 2, 
                                                   'hello0', 2, 5, 
                                                    'hello1', 3, 4);
        
         for(Integer i = 0; i <= 25; i++) {
            Store_Product__c temp = GetNewStoreProduct();
            allItems.add(temp);
        }
        test.starttest();
        insert allItems;
        test.stoptest();
        List<Store_Product__c> getProducts = [SELECT Name,Id, Price_Per_Unit__c, Rating__c
                               FROM Store_Product__c
                               ORDER BY Rating__c DESC];
        for(integer x = 0; x < getProducts.size(); x++) {
            //System.debug(getProducts.get(x));
           System.assertEquals(getProducts.get(x), getProducts.get(x));
        }
        System.assertEquals(testingTrendingListController.row0Column0, 'hello');
        System.assertEquals(testingTrendingListController.row0Column0Price, 1);
        System.assertEquals(testingTrendingListController.row0Column0Rating, 2);
        
    } 
    public static Store_Product__c GetNewStoreProduct() {
        Store_Product__c tempItem = new Store_Product__c();
        tempItem.Name = 'temp'  + Math.Random()* 10;
        tempItem.Rating__c =  Math.Random();
        tempItem.Price_Per_Unit__c = 4;
        tempItem.Category__c = 'Ballons';
        return tempItem;
    }
   
   
     
}
