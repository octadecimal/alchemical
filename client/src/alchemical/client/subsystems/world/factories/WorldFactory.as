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
		static public function createShip(id:int):Ship
		{
			var ship:Ship = new Ship(id);
			return ship;
		}
	}

}