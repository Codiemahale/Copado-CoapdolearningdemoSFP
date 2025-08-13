@isTest
public class ContactHandlerTest {
    @isTest
    static void testContactHandler() {
        // Create a test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create test contacts
        Contact contact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id);
        Contact contact2 = new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccount.Id);

        insert new List<Contact> { contact1, contact2 };

        // Verify that the account is updated after inserting contacts
        testAccount = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(2, testAccount.Number_of_Contacts__c);

        // Update contact by changing account
        Account testAccount2 = new Account(Name = 'Second Account');
        insert testAccount2;

        contact1.AccountId = testAccount2.Id;
        update contact1;

        // Verify account update after changing contact's account
        testAccount = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        testAccount2 = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :testAccount2.Id];
        System.assertEquals(1, testAccount.Number_of_Contacts__c);
        System.assertEquals(1, testAccount2.Number_of_Contacts__c);

        // Delete a contact
        delete contact2;

        // Verify account update after deleting contact
        testAccount = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(0, testAccount.Number_of_Contacts__c);

        // Clean up
        delete new List<Account> { testAccount, testAccount2 };
    }
}