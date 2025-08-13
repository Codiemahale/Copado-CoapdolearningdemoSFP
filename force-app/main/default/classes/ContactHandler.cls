public class ContactHandler {
    public static void updateContactCountOnAccount(List<Contact> newContacts, Map<Id, Contact> oldContactsMap) {
        Set<Id> accountIds = new Set<Id>();
        
        // Gathering account Ids from newContacts and oldContactsMap
        for (Contact c : newContacts) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }
        if (oldContactsMap != null) {
            for (Contact oldContact : oldContactsMap.values()) {
                if (oldContact.AccountId != null) {
                    accountIds.add(oldContact.AccountId);
                }
            }
        }      
        // Query the affected accounts
        List<Account> accountsToUpdate = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN :accountIds];
        
        // Update contact count for each affected account
        for (Account acc : accountsToUpdate) {
            acc.Number_of_Contacts__c = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id];
        }
        // Update accounts
        update accountsToUpdate;
    }
}