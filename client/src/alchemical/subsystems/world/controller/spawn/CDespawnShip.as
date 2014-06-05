/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.spawn 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.model.vo.spawn.DespawnShipVO;
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
			
			world.removeEntity(vo.id);
		}
	}

}