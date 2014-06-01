/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.mediator.ResourcesMediator;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.resources.Resources;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemLoading
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemResources extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if(CONFIG::debug) Debugger.info(this, "Creating subsystem: " + ComponentNames.RESOURCES);
			
			var resources:Resources = new Resources();
			resources.verbose = true;
			
			facade.registerProxy(new ResourcesProxy(resources));
			facade.registerMediator(new ResourcesMediator(resources));
			
			if(CONFIG::debug) Debugger.info(this, "Subsystem created: " + ComponentNames.RESOURCES);
			commandComplete();
		}
	}

}