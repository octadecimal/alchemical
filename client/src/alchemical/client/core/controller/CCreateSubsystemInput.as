/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.input.mediator.InputMediator;
	import alchemical.client.subsystems.input.model.InputProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.core.Starling;
	import starling.display.Stage;
	
	/**
	 * CCreateSubsystemInput
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemInput extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.INPUT);
			
			// Get starling
			var starling:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Register
			facade.registerProxy(new InputProxy());
			facade.registerMediator(new InputMediator(starling.stage));
			
			Debugger.log(this, "Created: " + ComponentNames.INPUT);
			commandComplete();
		}
	}

}