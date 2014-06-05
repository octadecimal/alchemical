/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.spawn 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.world.model.vo.ships.ShipEngineVO;
	import alchemical.subsystems.world.model.vo.ships.ShipHullVO;
	import alchemical.subsystems.world.model.vo.spawn.DespawnShipVO;
	import alchemical.subsystems.world.model.WorldProxy;
	import alchemical.subsystems.world.ships.Ship;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDespawnShip
	 * @author Dylan Heyes
	 */
	public class CDespawnShip extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:DespawnShipVO = notification.getBody() as DespawnShipVO;
			if (CONFIG::debug) Debugger.log(this, "Despawning ship: " + vo.id);
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			
			// Get ship
			var ship:Ship = world.getEntity(vo.id) as Ship;
			
			// Remove from world
			world.removeEntity(vo.id);
			
			// Dispose ship
			ship.dispose();
			
			// Undeclare hull
			var hullDefinition:ShipHullVO = worldProxy.shipHullDefinitions[ship.hull];
			resourcesProxy.undeclareTexture(hullDefinition.texture);
			
			// Undeclare engines
			for (var i:int = 0, c:int = ship.engines.length; i < c; i++)
			{
				var engineDefinition:ShipEngineVO = worldProxy.shipEngineDefinitions[ship.engines[i]];
				resourcesProxy.undeclareTexture(engineDefinition.texture)
			}
		}
	}

}