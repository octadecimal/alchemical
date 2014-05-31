/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.load 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.world.model.vo.SkyVO;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.textures.Texture;
	
	/**
	 * CLoadSky
	 * @author Dylan Heyes
	 */
	public class CLoadSky extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:SkyVO = notification.getBody() as SkyVO;
			if (CONFIG::debug) Debugger.log(this, "Loading sky... (" + vo.layers + ")");
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			
			// Declare textures
			for (var i:int = 0; i < vo.layers.length; i++)
			{
				resourcesProxy.declareSkyTexture(vo.layers[i]);
			}
			
			// Load textures
			resourcesProxy.load(function onProgress(ratio:Number):void
			{
				if (CONFIG::debug) Debugger.progress(ratio);
				
				if (ratio >= 1)
				{
					if (CONFIG::debug) Debugger.log(this, "Sky textures loaded.");
					
					var skyTextures:Vector.<Texture> = new Vector.<Texture>(vo.layers.length);
					
					for (i = 0; i < vo.layers.length; i++)
					{
						skyTextures[i] = resourcesProxy.getSkyTexture(vo.layers[i]);
					}
					
					world.sky.setLayerTextures(skyTextures);
				}
			});
		}
	}

}