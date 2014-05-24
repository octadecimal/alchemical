/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.debugger.mediator.DebuggerMediator;
	import alchemical.client.debugger.WorldStats;
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
			var debugger:Debugger = new Debugger();
			facade.registerMediator(new DebuggerMediator(debugger));
			
			debugger.worldStats = new WorldStats();
			
			commandComplete();
		}
	}
}