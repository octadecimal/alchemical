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
	import alchemical.subsystems.world.model.vo.spawn.SpawnShipVO;
	import alchemical.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CSpawnShip
	 * @author Dylan Heyes
	 */
	public class CLoadShipTextures extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:SpawnShipVO = notification.getBody() as SpawnShipVO;
			if (CONFIG::debug) Debugger.log(this, "Spawning ship: " + vo.id);
			
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			var hullDefinition:ShipHullVO = worldProxy.shipHullDefinitions[vo.id];
			
			// Declare hull textures
			resourcesProxy.declareTexture(hullDefinition.texture);
			
			// Declare engine textures
			for (var i:int = 0, c:int = vo.engines.length; i < c;  i++)
			{
				var engineDefinition:ShipEngineVO = worldProxy.shipEngineDefinitions[vo.engines[i]];
				resourcesProxy.declareTexture(engineDefinition.texture);
			}
			
			resourcesProxy.load(function onProgress(ratio:Number):void
			{
				if (CONFIG::debug) Debugger.progress(ratio);
				
				if (ratio >= 1)
				{
					if (CONFIG::debug) Debugger.log(this, "Ship textures loaded: " + vo.id);
					commandComplete();
				}
			});
		}
	}

}