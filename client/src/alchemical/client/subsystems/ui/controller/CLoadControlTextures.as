/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.ui.model.UIProxy;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.utils.AssetManager;
	
	/**
	 * CLoadControls
	 * @author Dylan Heyes
	 */
	public class CLoadControlTextures extends AsyncCommand
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Loading texture atlas: controls");
			
			// Get ui
			var uiProxy:UIProxy = facade.retrieveProxy(ComponentNames.UI) as UIProxy;
			
			// Get resources
			var resources:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			
			// Enqueue
			resources.enqueue(File.applicationDirectory.resolvePath("textures/controls.atf"));
			resources.enqueue(File.applicationDirectory.resolvePath("textures/controls.xml"));
			
			// Load
			resources.loadQueue(function (ratio:Number):void
			{
				if (ratio >= 1)
				{
					// Set controls atlas
					uiProxy.atlasControls = resources.getTextureAtlas("controls");
					
					// Complete
					Debugger.log(this, "Loaded texture atlas: controls");
					commandComplete();
				}
			});
		}
	}

}