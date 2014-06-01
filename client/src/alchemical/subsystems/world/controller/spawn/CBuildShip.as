/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.spawn 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.world.model.nodes.DynamicsNode;
	import alchemical.subsystems.world.model.nodes.TransformNode;
	import alchemical.subsystems.world.model.vo.spawn.SpawnShipVO;
	import alchemical.subsystems.world.model.WorldProxy;
	import alchemical.subsystems.world.ships.Ship;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * CBuildShip
	 * @author Dylan Heyes
	 */
	public class CBuildShip extends AsyncCommand
	{
		override public function execute(notification:INotification):void 
		{
			var vo:SpawnShipVO = notification.getBody() as SpawnShipVO;
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			
			// Ship entity
			var ship:Ship = new Ship(new Sprite(), new TransformNode(vo.x, vo.y, vo.r), new DynamicsNode());
			
			// Hull
			var hullTexture:Texture = resourcesProxy.getShipHullTexture(vo.id);
			ship.setHullTexture(hullTexture);
			
			// Add to world
			world.addEntity(ship);
			
		}
	}

}