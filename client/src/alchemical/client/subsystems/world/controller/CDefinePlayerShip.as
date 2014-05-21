/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDefinePlayerShip
	 * @author Dylan Heyes
	 */
	public class CDefinePlayerShip extends SimpleCommand
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Defining player ship...");
			
			var vo:ShipVO = notification.getBody() as ShipVO;
			
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			worldProxy.playerShipDefinition = vo;
			
			Debugger.log(this, "Defined player ship. id=" + vo.id + " type=" + vo.type+" hull=" + vo.hull);
		}
	}

}