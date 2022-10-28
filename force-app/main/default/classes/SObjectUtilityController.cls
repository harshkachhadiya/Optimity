public with sharing class SObjectUtilityController {
    
    public static Map<String, String> getPicklistOptions(String sobjectApiName, String fieldApiName) {
        
        Map<String, String> result = new Map<String, String>();
        
        for(Schema.PicklistEntry picklistEntry : Schema.getGlobalDescribe().get(sobjectApiName.toLowerCase()).getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues()) {
            result.put(picklistEntry.getValue(), picklistEntry.getLabel());
        }    
        
        return result;
    }
    
    public static Map<String, List<String>> getDependentPicklistValues(Schema.SObjectField dependToken) {
        
        Map<String, List<String>> dependentPicklistValues = new Map<String, List<String>>();
        
        //Get dependent field result
        Schema.DescribeFieldResult depend = dependToken.getDescribe();
        
        //Get dependent field controlling field 
        Schema.SObjectField controlToken = depend.getController();
        
        //Check controlling field is not null
        if (controlToken == null) {
            return new Map<String, List<String>>();
        }
        
        //Get controlling field result
        Schema.DescribeFieldResult control = controlToken.getDescribe();
        
        //Get controlling field picklist values if controlling field is not a checkbox
        List<Schema.PicklistEntry> controlEntries;
        if(control.getType() != Schema.DisplayType.Boolean) {
            controlEntries = control.getPicklistValues();
        }
        
        //It is used to decode the characters of the validFor fields
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        
        for (Schema.PicklistEntry entry : depend.getPicklistValues()) {
            
            //The PicklistEntry is serialized and deserialized using the Apex JSON class and it will check to have a 'validFor' field
            if (entry.isActive() && String.isNotEmpty(String.valueOf(((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')))) {
                
                List<String> base64chars = String.valueOf(((Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')).split('');
                
                for (Integer index = 0; index < (controlEntries != null ? controlEntries.size() : 2); index++) {

                    Object controlValue = (controlEntries == null
                                           ? (Object) (index == 1)
                                           : (Object) (controlEntries[index].isActive() ? controlEntries[index].getValue () : null)
                                          );
                    Integer bitIndex = index / 6;
                    
                    if (bitIndex > base64chars.size() - 1) {
                        break;
                    }
                    
                    Integer bitShift = 5 - Math.mod(index, 6);
                    
                    if (controlValue == null || (base64map.indexOf( base64chars[bitIndex]) & (1 << bitShift)) == 0) {
                        continue;
                    }
                    
                    if (!dependentPicklistValues.containsKey((String) controlValue)) {
                        dependentPicklistValues.put((String) controlValue, new List<String>());
                    }
                    
                    dependentPicklistValues.get((String) controlValue).add(entry.getValue());
                }
            }
        }

        return dependentPicklistValues;
    }

    public static List<Schema.FieldSetMember> getFieldSetDetails(String sobjectApiName, String fieldSetApiName) {
        
        return Schema.getGlobalDescribe().get(sobjectApiName.toLowerCase()).getDescribe().FieldSets.getMap().get(fieldSetApiName).getFields(); 
    }   
    
    public static List<String> getFieldApiNamesByFieldSet(String sobjectApiName, String fieldSetApiName) {
        
        List<String> result = new List<String>();
        
        for(Schema.FieldSetMember fieldSetMember : getFieldSetDetails(sobjectApiName, fieldSetApiName)) {
            result.add(fieldSetMember.getFieldPath());
        }
        
        return result;
    }

    public static Id getRecordTypeIdByName(String sobjectApiName, String recordTypeName) {
        
        return Schema.getGlobalDescribe().get(sobjectApiName).getDescribe().getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }

    public static Id getRecordTypeIdByDeveloperName(String sobjectApiName, String recordTypeDeveloperName) {
        
        return Schema.getGlobalDescribe().get(sobjectApiName).getDescribe().getRecordTypeInfosByDeveloperName().get(recordTypeDeveloperName).getRecordTypeId();
    }

    public static String getSobjectApiNameById(Id recordId) {
        
        return recordId.getSObjectType().getDescribe().getName();
    }

    public static List<String> getFieldApiNamesByFieldSet(String sobjectApiName) {
        
        List<String> result = new List<String>();

        for(Schema.SObjectField field : Schema.getGlobalDescribe().get().getDescribe().fields.getMap().values()) {
            result.add(field.getDescribe().getName());
        }

        return result;
    }
}