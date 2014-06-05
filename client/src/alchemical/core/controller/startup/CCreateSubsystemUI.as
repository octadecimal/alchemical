/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.ui.mediator.UIMediator;
	import alchemical.subsystems.ui.UILayer;
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
			if (CONFIG::debug) Debugger.info(this, "Creating subsystem: " + ComponentNames.UI);
			
			var uiLayer:UILayer = new UILayer();
			facade.registerMediator(new UIMediator(uiLayer));
			
			if (CONFIG::debug) Debugger.info(this, "Subsystem created: " + ComponentNames.UI);
			commandComplete();
		}
	}

}