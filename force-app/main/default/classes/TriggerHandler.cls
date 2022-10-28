public  with sharing virtual class TriggerHandler {
    
    public TriggerHandler() {
        
    }
    
    // main method that will be called during execution
    public void run(){
        if (Trigger.isBefore && Trigger.isInsert) {
            this.beforeInsert();
        } else if (Trigger.isBefore && Trigger.isUpdate) {
            this.beforeUpdate();
        } else if (Trigger.isBefore && Trigger.isDelete) {
            this.beforeDelete();
        } else if (Trigger.isAfter && Trigger.isInsert) {
            this.afterInsert();
        } else if (Trigger.isAfter && Trigger.isUpdate) {
            this.afterUpdate();
        } else if (Trigger.isAfter && Trigger.isDelete) {
            this.afterDelete();
        } else if (Trigger.isAfter && Trigger.isUndelete) {
            this.afterUndelete();
        }
    }

    // context-specific methods for override
    @TestVisible protected virtual void beforeInsert() {

    }

    @TestVisible protected virtual void beforeUpdate() {

    }

    @TestVisible protected virtual void beforeDelete() {

    }

    @TestVisible protected virtual void afterInsert() {

    }

    @TestVisible protected virtual void afterUpdate() {

    }

    @TestVisible protected virtual void afterDelete() {

    }

    @TestVisible protected virtual void afterUndelete() {

    }
}