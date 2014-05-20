/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.notes.WorldNotes;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CNotifyWorldReady
	 * @author Dylan Heyes
	 */
	public class CNotifyWorldReady extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			sendNotification(WorldNotes.WORLD_READY);
			commandComplete();
		}
	}

}