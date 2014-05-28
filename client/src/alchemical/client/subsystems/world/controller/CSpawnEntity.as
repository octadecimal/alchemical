/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.network.model.vo.NetworkEntityVO;
	import alchemical.client.subsystems.world.entities.Entity;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CSpawnEntity
	 * @author Dylan Heyes
	 */
	public class CSpawnEntity extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var networkEntity:NetworkEntityVO = NetworkEntityVO(notification.getBody());
			
			// References
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			// Create entity
			var entity:Entity = new Entity(networkEntity.id, networkEntity.vessel, networkEntity.transform, networkEntity.dynamics);
			
			// Register entity
			worldProxy.registerEntity(entity);
		}
	}

}