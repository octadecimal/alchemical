/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.resources.mediator.ResourcesMediator;
	import alchemical.client.subsystems.resources.Resources;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.utils.AssetManager;
	
	/**
	 * CCreateSubsystemLoading
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemResources extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.RESOURCES);
			
			var assetManager:Resources = new Resources();
			assetManager.verbose = true;
			
			facade.registerMediator(new ResourcesMediator(assetManager));
			
			Debugger.log(this, "Created: " + ComponentNames.RESOURCES);
			commandComplete();
		}
	}

}