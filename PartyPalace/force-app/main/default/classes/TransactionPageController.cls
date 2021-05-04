public class TransactionPageController {
    public Transaction__c trans{get;set;}
    public List<Product_Line__c> productLines{get;set;}
    Id currentUser = UserInfo.getUserId();
    CurrentTransaction currentTrans = new CurrentTransaction();
    public List<String> TotalCost {get;set;}
    
    public TransactionPageController(){
        trans = currentTrans.Trans;
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c, Total_Cost__c FROM Product_Line__c WHERE Transaction__c =: trans.id];
        TotalCost = new List<String>();
        for (Product_Line__c pl : productLines){
      		String tc = String.valueOf(pl.Total_Cost__c);
            TotalCost.add(tc);
        }

    }
    

    public PageReference save(){
        trans.Status__c = 'Closed';
        Transaction__c newTransaction = new Transaction__c(Contact__c = trans.Contact__c, Store_Location__c = trans.Store_Location__c, Salesperson__c = trans.Salesperson__c, Status__c = 'Active');
        update trans;
        insert newTransaction;
        trans = newTransaction;
        currentTrans.setCurrentTransaction(newTransaction);
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c FROM Product_Line__c WHERE Transaction__c =: newTransaction.id];
        return Page.TransactionPage;
    }
    public PageReference updatePage(){
        update productLines;
        return Page.TransactionPage;
    }

    }