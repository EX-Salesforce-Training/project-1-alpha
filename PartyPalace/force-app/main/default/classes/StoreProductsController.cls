public class StoreProductsController {
    List<ProductsWrapper> productWrapper;
    
    public List<ProductsWrapper> getProductWrapper(){
        productWrapper = new List<ProductsWrapper>();
        List<Store_Product__c> allProducts = [SELECT Name,Id FROM Store_Product__c LIMIT 5];
        
        for(Store_Product__c p:allProducts){
            ProductsWrapper pw = new ProductsWrapper();
            pw.setProductInfo(p);
            productWrapper.add(pw);
        }
        
        return productWrapper;
    }

    public class ProductsWrapper{
        public Store_Product__c product;
        public String name{get;set;}

        public ProductsWrapper(){
            product = new Store_Product__c();
        }
        
        public void setProductInfo(Store_Product__c product){
            this.product.id = product.Id;
            this.name = product.Name;
        }
    }
}