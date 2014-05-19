/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.controller 
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CNetworkLogin
	 * @author Dylan Heyes
	 */
	public class CNetworkLogin extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			commandComplete();
		}
	}

}