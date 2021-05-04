public class TransactionPageController {
    public Transaction__c trans{get;set;}
    public Contact con{get;set;}
    public List<Product_Line__c> productLines{get;set;}
    Id currentUser = UserInfo.getUserId();
    
    public TransactionPageController(){
        User you = [SELECT Name, ContactID FROM User where id =: currentUser];
        trans = [SELECT Name, Contact__c, Status__c, Store_Location__c, Salesperson__c FROM Transaction__c WHERE Status__c =: 'Active' AND Contact__c =: you.ContactId];
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c FROM Product_Line__c WHERE Transaction__c =: trans.id];
    }

    public PageReference save(){
        trans.Status__c = 'Closed';
        Transaction__c newTransaction = new Transaction__c(Contact__c = trans.Contact__c, Store_Location__c = trans.Store_Location__c, Salesperson__c = trans.Salesperson__c, Status__c = 'Active');
        update trans;
        insert newTransaction;
        trans = newTransaction;
        productLines = [SELECT Name, Transaction__c, Product__c, Quantity__c FROM Product_Line__c WHERE Transaction__c =: newTransaction.id];
        return Page.TransactionPage;
    }
}