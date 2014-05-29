/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.entities.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.game.model.GameProxy;
	import alchemical.client.subsystems.network.model.vo.NetworkEntityVO;
	import alchemical.client.subsystems.resources.Resources;
	import alchemical.client.subsystems.world.model.vo.VesselVO;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.vessels.Vessel;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CLoadVessel
	 * @author Dylan Heyes
	 */
	public class CCreateVessel extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			// Entity VO
			var vo:VesselVO = NetworkEntityVO(note.getBody()).vessel;
			
			// References
			var gameProxy:GameProxy = facade.retrieveMediator(ComponentNames.GAME) as GameProxy;
			var worldProxy:WorldProxy = facade.registerMediator(ComponentNames.WORLD) as WorldProxy;
			var resources:Resources = facade.registerMediator(ComponentNames.RESOURCES) as Resources;
			
			// Load hull
			resources.declare(Resources.HULL + vo.hull);
			
			// Load engine bays
			for each(var engine:int in vo.engines)
				resources.declare(Resources.ENGINE + engine);
			
			// Load
			resources.loadQueue(function onProgress(ratio:Number):void
			{
				// Loaded
				if (ratio >= 1)
				{
					// Create vessel
					var vessel:Vessel = gameProxy.factories.vessels.createVessel(vo.vessel);
					
					// Complete
					commandComplete();
				}
			});
		}
	}

}