/*
 * -------------------------------------------------------------------------------------------------------------------------
 * @Name:			    AccountTriggerHelper
 * @Author: 			Harsh Kachhadiya (Optimity)
 * @Created Date: 		28/11/2022 (DD/MM/YYYY)
 * @Description:		Contains helper methods of Account trriger
 * @Dependancies:		Apex Class: AccountTriggerHanlder
 * @Test Classes:		-
 * @Test Coverage:		-
 * 
 * Changes (version)
 * -------------------------------------------------------------------------------------------------------------------------
 * 				No.		Date (DD/MM/YYYY)		Author					Description
 * 				----	------------------		--------------------	----------------------------------------------
 * @version		1.0		28/11/2022				Harsh Kachhadiya 		Initial Version
 * -------------------------------------------------------------------------------------------------------------------------
 */
public with sharing class AccountTriggerHelper {
    
    /*
    * ---------------------------------------------------------------------------------
    * @Description: Main method
    * @Param1: newAccounts - New list of Accounts
    * @Param2: oldMapAccounts - Old map of Accounts
    * @Return: void
    * ---------------------------------------------------------------------------------
    */
    public static void main(List<Account> newAccounts, Map<Id, Account> oldMapAccounts) {

        try {

        } catch(exception ex){
            System.debug('**********Error**********');
            System.debug('Class - AccountTriggerHelper');
            System.debug('Method - main');
            System.debug('Line Number :- ' + ex.getLineNumber());
            System.debug('Type :- ' + ex.getTypeName());
            System.debug('Message :- ' + ex.getMessage());
            System.debug('*************************');
        
            throw new AuraHandledException(ex.getMessage());
        }
    }
}