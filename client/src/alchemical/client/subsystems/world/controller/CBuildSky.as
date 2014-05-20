/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import alchemical.client.subsystems.world.Sky;
	import alchemical.client.subsystems.world.World;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.utils.AssetManager;
	
	/**
	 * CBuildSky
	 * @author Dylan Heyes
	 */
	public class CBuildSky extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var worldVO:WorldVO = notification.getBody() as WorldVO;
			
			var resources:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var sky:Sky = world.sky;
			
			const path:String = "textures/skies/";
			
			for (var i:int = 0; i < 4; i++)
			{
				resources.enqueue(File.applicationDirectory.resolvePath(path + worldVO.skyLayers[i] + ".png"));
			}
			
			resources.loadQueue(function (ratio:Number):void
			{
				if (ratio >= 1)
				{
					for (i = 0; i < 4; i++)
					{
						sky.setLayerAt(i, resources.getTexture(worldVO.skyLayers[i].toString()));
					}
					
					commandComplete();
				}
			});
		}
	}

}