/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.entities.controller 
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CLoadVessel
	 * @author Dylan Heyes
	 */
	public class CCreateVessel extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			
			
			commandComplete();
		}
	}

}