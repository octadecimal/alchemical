/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateDebugger
	 * @author Dylan Heyes
	 */
	public class CCreateDebugger extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			commandComplete();
		}
	}
}