/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.enum.EWorldScale;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.SkyLayer;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CProjectSky
	 * @author Dylan Heyes
	 */
	public class CProjectSky extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			var camera:Camera = world.camera;
			
			var worldWidth:Number = worldProxy.worldDefinition.width * EWorldScale.UNIT_SIZE;
			
			var cameraBounds:Number = worldWidth - camera.viewport.width;
			
			// Get first sky layer and constrain to the world size
			var bottomSkyLayer:SkyLayer = world.sky.layers[0];
			
			bottomSkyLayer.scrollX = (camera.transform.x / cameraBounds) * worldWidth;
		}
	}

}