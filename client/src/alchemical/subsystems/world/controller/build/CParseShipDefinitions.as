/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.build 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.model.vo.ships.ShipEnginebayVO;
	import alchemical.subsystems.world.model.vo.ships.ShipHullVO;
	import alchemical.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CParseShipDefinitions
	 * @author Dylan Heyes
	 */
	public class CParseShipDefinitions extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Parsing ship definitions...");
			
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			for each(var hull:XML in worldProxy.shipDefinitionsData.hulls.children())
			{
				var hullVO:ShipHullVO = new ShipHullVO();
				hullVO.id = int(hull.@id);
				hullVO.name = hull.@name;
				hullVO.texture = hull.@texture;
				hullVO.mass = Number(hull.stats.@mass);
				hullVO.armor = Number(hull.stats.@armor);
				
				for each(var enginebay:XML in hull.enginebays.children())
				{
					hullVO.enginebays.push(new ShipEnginebayVO(enginebay.@x, enginebay.@y));
				}
				
				worldProxy.shipHullDefinitions.push(hullVO);
				
				if (CONFIG::debug) Debugger.data(this, "Ship: " + hullVO.id + " -> " + hullVO.name);
			}
			
			worldProxy.shipDefinitionsData = null;
			
			if (CONFIG::debug) Debugger.log(this, "Parsed ship definitions.");
		}
	}

}