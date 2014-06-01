/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.notify 
{
	import alchemical.core.notifications.ApplicationNotifications;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CNotifySubsystemsInitialized
	 * @author Dylan Heyes
	 */
	public class CNotifySubsystemsInitialized extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.info(this, "All subsystems initialized.");
			sendNotification(ApplicationNotifications.SUBSYSTEMS_INITIALIZED);
		}
	}

}