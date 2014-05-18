/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.input.model.InputProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CParseControls
	 * @author Dylan Heyes
	 */
	public class CParseControls extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Parsing controls...");
			
			// Get input
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			
			// Get game options data
			var controlsXML:XML = inputProxy.getControlsData();
			
			// Register bindings
			for each(var controlNode:XML in controlsXML.children())
			{
				var action:String = controlNode.@action;
				var primary:String = controlNode.@primary;
				var secondary:String = controlNode.@secondary;
				
				inputProxy.registerControlBinding(action, primary, secondary);
			}
			
			// Command complete
			Debugger.log(this, "Parsed controls.");
			commandComplete();
		}
	}

}