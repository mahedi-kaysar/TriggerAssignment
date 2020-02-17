@isTest
private class AccountTriggerTest {
  
    /**
     * This method tests the AccountTrigger on bulk upadate of Accounts (changing Total__c value)
     * and see that shares are equally distributted amoung the contacts of associated accounts.
     */
    @isTest static void distributeShareEquallyToContacts_onAfterUpdateAccount() {  
        List<Account> accounts = TestDataFactory.createAccounts(2);
        TestDataFactory.createContacts(accounts[0], 2);
        TestDataFactory.createContacts(accounts[1], 1);
        Test.startTest();
        accounts[0].Total__c = 200;
        accounts[1].Total__c = 200;
        upsert accounts;
        List<Contact> contactOfAccount1 = [SELECT AccountId, Share__c FROM Contact WHERE AccountId = :accounts[0].Id];
        System.assertEquals(100, contactOfAccount1[0].Share__c);
        System.assertEquals(100, contactOfAccount1[1].Share__c);
        List<Contact> contactOfAccount2 = [SELECT AccountId, Share__c FROM Contact WHERE AccountId = :accounts[1].Id];
        System.assertEquals(200, contactOfAccount2[0].Share__c);
        Test.stopTest();
      }
}
