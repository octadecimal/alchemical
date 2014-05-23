/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.entities.Player;
	import alchemical.client.subsystems.world.World;
	import flash.geom.Point;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CHandleWorldClicked
	 * @author Dylan Heyes
	 */
	public class CHandleWorldClicked extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var position:Point = notification.getBody() as Point;
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var player:Player = facade.retrieveMediator(ComponentNames.PLAYER).getViewComponent() as Player;
			var camera:Camera = world.camera;
			
			camera.projectPoint(position);
			
			player.moveTo(position);
		}
	}

}