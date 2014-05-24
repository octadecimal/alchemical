/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.entities.Player;
	import alchemical.client.subsystems.world.mediator.PlayerMediator;
	import alchemical.client.subsystems.world.Sky;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CProjectCamera
	 * @author Dylan Heyes
	 */
	public class CProjectCamera extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var camera:Camera = world.camera;
			
			// Clamp camera position
			camera.transform.x = Math.max(camera.transform.x, 0);
			camera.transform.x = Math.min(camera.transform.x, world.worldBounds.width - camera.viewport.width);
			camera.transform.y = Math.max(camera.transform.y, 0);
			camera.transform.y = Math.min(camera.transform.y, world.worldBounds.height - camera.viewport.height);
			
			// Project player (testing)
			var playerMediator:PlayerMediator = facade.retrieveMediator(ComponentNames.PLAYER) as PlayerMediator;
			
			if (playerMediator)
			{
				var player:Player = playerMediator.getViewComponent() as Player;
				player.project(world.camera);
			}
		}
	}

}