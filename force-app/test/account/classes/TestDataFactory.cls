@isTest
public class TestDataFactory {
    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<numAccts; i++) {
            Account a = new Account(Name='TestAccount' + i);
            accounts.add(a);
        }
        
        insert accounts;
        return accounts;
    }

    public static List<Contact> createContacts(Account account, Integer numContacts) {
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<numContacts; i++) {
            Contact contact = new Contact(
                FirstName='firstName' + i,
                LastName='lastName' + i,
                Phone='phone' + i,
                AccountId=account.Id);
            contacts.add(contact);
        }

        insert contacts;
        return contacts;
    }
}
