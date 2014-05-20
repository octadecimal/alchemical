/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.notes.ApplicationNotes;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CNotifySystemReady
	 * @author Dylan Heyes
	 */
	public class CNotifySystemReady extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			sendNotification(ApplicationNotes.SYSTEM_READY);
			commandComplete();
		}
	}

}