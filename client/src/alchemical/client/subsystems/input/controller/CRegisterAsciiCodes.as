/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.input.enum.EKeys;
	import alchemical.client.subsystems.input.model.InputProxy;
	import flash.ui.Keyboard;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CRegisterKeyboardAsciiCodes
	 * @author Dylan Heyes
	 */
	public class CRegisterAsciiCodes extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Registering ascii codes...");
			
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			
			inputProxy.registerAsciiCode(Keyboard.W, EKeys.W);
			inputProxy.registerAsciiCode(Keyboard.S, EKeys.S);
			inputProxy.registerAsciiCode(Keyboard.A, EKeys.A);
			inputProxy.registerAsciiCode(Keyboard.D, EKeys.D);
			
			inputProxy.registerAsciiCode(Keyboard.UP, EKeys.UP);
			inputProxy.registerAsciiCode(Keyboard.DOWN, EKeys.DOWN);
			inputProxy.registerAsciiCode(Keyboard.LEFT, EKeys.LEFT);
			inputProxy.registerAsciiCode(Keyboard.RIGHT, EKeys.RIGHT);
			
			inputProxy.registerAsciiCode(Keyboard.F2, EKeys.F2);
			inputProxy.registerAsciiCode(Keyboard.F3, EKeys.F3);
			
			Debugger.log(this, "Registered ascii codes.");
			commandComplete();
		}
	}

}