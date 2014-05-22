/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.factories 
{
	import alchemical.client.subsystems.world.entities.Ship;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	
	/**
	 * WorldFactory
	 * @author Dylan Heyes
	 */
	public class WorldFactory 
	{
		static public function createShip(vo:ShipVO):Ship
		{
			var ship:Ship = new Ship(vo);
			return ship;
		}
	}

}