/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.input.mediator.InputMediator;
	import alchemical.subsystems.input.model.InputProxy;
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
			if (CONFIG::debug) Debugger.info(this, "Creating subsystem: " + ComponentNames.INPUT);
			
			// Get starling
			var starling:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Register
			var proxy:InputProxy = new InputProxy();
			facade.registerProxy(proxy);
			facade.registerMediator(new InputMediator(starling.stage));
			
			// Default focus to world
			proxy.focus = ComponentNames.WORLD;
			
			if (CONFIG::debug) Debugger.info(this, "Created subsystem: " + ComponentNames.INPUT);
			commandComplete();
		}
	}

}