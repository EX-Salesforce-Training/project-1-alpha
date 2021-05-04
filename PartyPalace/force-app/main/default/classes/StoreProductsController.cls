public with sharing class StoreProductsController {
    List<ProductsWrapper> productWrapper;
    static Integer currentPage; 
    static Integer totalPages;
    
    // GetProductWrapper is aGetter class to retrieve the product information and display it on the Visualforce Page
    // This only provides data for a 3x5 grid.
    public List<ProductsWrapper> GetProductWrapper(){
        productWrapper = new List<ProductsWrapper>();
        
        // check to see if we are on a new instance of the page
        if(currentPage == null){
            currentPage = 0;
            List<Store_Product__c> allProducts = [SELECT Name,Id FROM Store_Product__c LIMIT 15];
            List<Store_Product__c> totalProducts = [SELECT Name,Id FROM Store_Product__c];        
            totalPages = (totalProducts.size()/15) + 1;
            
            //render the entire shits
            for(Integer i = 0; i < 5; i++){
                ProductsWrapper pw = new ProductsWrapper();
                String col1 = allProducts.get(i).Name;
                String col2 = allProducts.get(i+5).Name;
                String col3 = allProducts.get(i+10).Name;
                
                pw.setProductInfo(col1, col2, col3);
                productWrapper.add(pw);
                
            }
            
            
            
            // load page based on current page
            // current page helps calculate offset
        }else if(currentpage >= 0 || currentPage < totalPages){
            Integer offset = currentPage * 15;
            system.debug('offset: ' + offset);
            string s = 'SELECT Name,Id FROM Store_Product__c LIMIT 15 OFFSET ' + offset;
            List<Store_Product__c> pageProducts = Database.query(s);
            system.debug('initial pageProducts:' + pageProducts.size());
            
            if(pageProducts.size() == 15){
                //render the entire shits
                system.debug('all the shits');
                for(Integer i = 0; i < 5; i++){
                    ProductsWrapper pw = new ProductsWrapper();
                    String col1 = pageProducts.get(i).Name;
                    String col2 = pageProducts.get(i+5).Name;
                    String col3 = pageProducts.get(i+10).Name;
                    
                    pw.setProductInfo(col1, col2, col3);
                    productWrapper.add(pw);
                    
                }
                
            }else if(pageProducts.size() < 15){
                ProductsWrapper pw = new ProductsWrapper();
                //render some of the shits
                system.debug('some of the shits');
                
                for(Integer i = 0; i < pageProducts.size(); i++){
                    system.debug('amt of pageProducts: ' + pageProducts.size());
                    system.debug('pageProducts: ' + pageProducts);
                    if(pageProducts.isEmpty()){
                        	system.debug('empty!');
                            break;
                        }
                    for(Integer j = 0; j < 3; j++ ){
                        if(pageProducts[i] != null && pw.col1 == null){
                            pw.col1 = pageProducts[i].Name;
                            break;
                            //pageProducts.remove(0);

                        }else if(pageProducts[i] != null && pw.col2 == null){
                            pw.col2 = pageProducts[i].Name;
                            break;
                            //pageProducts.remove(0);
                            
                        }else if(pageProducts[i] != null && pw.col3 == null){
                            pw.col3 = pageProducts[i].Name;
                            productWrapper.add(pw);
                            //pageProducts.remove(0);
                            pw = new ProductsWrapper();
                            break;
                            
                        }
                    }
                }
                
                if(pw.col1 != null){
                    productWrapper.add(pw);
                }
                
            }
            
        }

        return productWrapper;
    }
    
    
    public class ProductsWrapper{
        public Store_Product__c product;
        public String col1{get;set;}
        public String col2{get;set;}
        public String col3{get;set;}

        public ProductsWrapper(){
            product = new Store_Product__c();
            
        }
        
        public void setProductInfo(String col1, string col2, String col3){
            this.product.id = product.Id;
          	this.col1 = col1;
            this.col2 = col2;
            this.col3 = col3;
           
        }
        
    }

    public PageReference next(){
  
        if((currentPage+1) < totalPages){
            currentPage++;
            return Page.StoreProductsView;
            
        }
        
        return Page.StoreProductsView;
        
    }
    
    public PageReference prev(){
        
        if((currentPage-1) >= 0){
            currentPage--;
            return Page.StoreProductsView;
            
        }
        
        return Page.StoreProductsView;
       
    }
    
    public void AddToCart(){
        Id currentUser = UserInfo.getUserId();
        
    }
    
   
}