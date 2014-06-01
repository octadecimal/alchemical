/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.input.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.input.enum.EActions;
	import alchemical.subsystems.input.model.InputProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CRegisterActions
	 * @author Dylan Heyes
	 */
	public class CRegisterActions extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Registering actions...");
			
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			
			inputProxy.registerAction("move_up", EActions.MOVE_UP);
			inputProxy.registerAction("move_down", EActions.MOVE_DOWN);
			inputProxy.registerAction("move_left", EActions.MOVE_LEFT);
			inputProxy.registerAction("move_right", EActions.MOVE_RIGHT);
			
			inputProxy.registerAction("enter_full_screen", EActions.ENTER_FULL_SCREEN);
			inputProxy.registerAction("exit_full_screen", EActions.EXIT_FULL_SCREEN);
			
			inputProxy.registerAction("chat", EActions.CHAT);
			inputProxy.registerAction("chat_command", EActions.CHAT_COMMAND);
			
			if (CONFIG::debug) Debugger.log(this, "Registered actions.");
			commandComplete();
		}
	}

}