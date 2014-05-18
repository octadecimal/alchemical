/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.ui.mediator.UIMediator;
	import alchemical.client.subsystems.ui.model.UIProxy;
	import alchemical.client.subsystems.ui.UILayer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemUI
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemUI extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.UI);
			
			facade.registerProxy(new UIProxy());
			facade.registerMediator(new UIMediator(new UILayer()));
			
			Debugger.log(this, "Created: " + ComponentNames.UI);
			commandComplete();
		}
	}

}