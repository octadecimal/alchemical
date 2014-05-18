/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.input.model.InputProxy;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.utils.AssetManager;
	/**
	 * CInitializeInput
	 * @author Dylan Heyes
	 */
	public class CLoadControls extends AsyncCommand
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Loading controls data....");
			
			// Get input proxy
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			
			// Get asset manager
			var resources:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			
			// Enqueue
			resources.enqueue(File.applicationDirectory.resolvePath("data/controls.xml"));
			
			// Load
			resources.loadQueue(function (ratio:Number):void
			{
				if (ratio >= 1)
				{
					inputProxy.setControlsData(resources.getXml("controls"));
					
					commandComplete();
				}
			});
		}
		
		override protected function commandComplete():void 
		{
			Debugger.log(this, "Loaded controls data.");
			super.commandComplete();
		}
	}

}