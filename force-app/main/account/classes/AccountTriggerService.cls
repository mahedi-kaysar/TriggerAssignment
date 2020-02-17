/**
 * This is a service class for the Triggers on Account Object.
 */
public with sharing class AccountTriggerService {
    /**
     * This method divide the Total__c value of each Account by the total number of associated contacts
     * and update the Share__c filed of each contact by its value.
     * 
     * @param accountMap is a Map of Account with its Id.
     */
    public void distributeShareEquallyToContacts(Map<Id, Account> accountMap) {
        List<Contact> updatedContacts = new List<Contact>();
        Map<Id, List<Contact>> contactsByAccount = this.getContactsByAccount(accountMap.keySet());
        for(Id accountId: accountMap.keySet()) {
            Account account = accountMap.get(accountId);
            List<Contact> oldContacts = contactsByAccount.get(accountId);
            Double total = account.Total__c;
            if(oldContacts.size() > 0) {
                Double eachShare = total / oldContacts.size();
                for(Contact oldContact : oldContacts) {
                    oldContact.Share__c = eachShare;
                    System.debug('AccountID=' + accountId 
                        + 'ContactID=' + oldContact.Id + 'New Share=' + oldContact.Share__C);
                }
            }
            updatedContacts.addAll(oldContacts);        
        } 
        this.updateContacts(updatedContacts);
    }

    /**
     * This method finds the assocated contacts of each account. 
     */
    private Map<Id, List<Contact>> getContactsByAccount(Set<Id> accountIds) {
        Map<Id, List<Contact>> contactsByAccount = new Map<Id, List<Contact>>();
        for(Id accountId: accountIds) {
            contactsByAccount.put(accountId, new Contact[0]);
        }
        for(Contact contact: [SELECT Id, AccountId, Share__c FROM Contact WHERE AccountId IN :accountIds]) {
            contactsByAccount.get(contact.AccountId).add(contact);
        }
        return contactsByAccount;
    }

    /**
     * This method update the list of contacts.
     */
    private void updateContacts(List<Contact> contactsToUpdate) {
        try {
            if (!contactsToUpdate.isEmpty()){
                upsert contactsToUpdate;
                System.debug('Contacts are updated successfully');  
            }    
        } catch (DmlException ex) {
            System.debug('Exception occured while updating contacts: ' + ex.getCause());
        }
    }
}