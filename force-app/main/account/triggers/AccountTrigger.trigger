/**
 * An AccountTrigger.
 */
trigger AccountTrigger on Account (after insert, after update) {
    if (Trigger.isAfter || Trigger.isUpdate) {
        AccountTriggerService accountTriggerService = new AccountTriggerService();
        accountTriggerService.distributeShareEquallyToContacts(Trigger.newMap);
    }
}