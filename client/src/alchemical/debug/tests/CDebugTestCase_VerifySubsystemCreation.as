/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.tests 
{
	import org.puremvc.as3.interfaces.INotification;
	/**
	 * CDebugTestCase_VerifySubsystemCreation
	 * @author Dylan Heyes
	 */
	public class CDebugTestCase_VerifySubsystemCreation extends CDebugTestCase 
	{
		override public function execute(notification:INotification):void 
		{
			name = "VerifySubsystemCreation";
			super.execute(notification);
			
			pass();
		}
	}

}