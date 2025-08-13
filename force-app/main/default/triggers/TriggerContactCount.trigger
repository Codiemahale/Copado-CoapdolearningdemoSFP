trigger TriggerContactCount on Contact (after insert, after update, after delete) {
    ContactHandler.updateContactCountOnAccount(Trigger.new, Trigger.oldMap);
}