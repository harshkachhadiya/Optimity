public with sharing class AccountTriggerHanlder extends TriggerHandler {

    private List<Account> oldSObjects;
	private List<Account> newSObjects;
	private Map<Id, Account> oldMapSObjects;
	private Map<Id, Account> newMapSObjects;
	
	public AccountTriggerHanlder() {
		oldSObjects = (List<Account>) Trigger.old;
		newSObjects = (List<Account>) Trigger.new;
		oldMapSObjects = (Map<Id, Account>) Trigger.oldMap;
		newMapSObjects = (Map<Id, Account>) Trigger.newmap;
	}

    protected override void beforeInsert() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void beforeUpdate() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void beforeDelete() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void afterInsert() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void afterUpdate() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void afterDelete() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
	
	protected override void afterUndelete() {
		AccountTriggerHelper.main(newSObjects, oldMapSObjects);
	}
}
