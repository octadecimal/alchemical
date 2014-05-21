package alchemical.client.subsystems.world.model
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.model.vo.PlayerVO;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * WorldProxy
	 * @author Dylan Heyes
	 */
	public class WorldProxy extends Proxy 
	{
		/**
		 * Consturctor.
		 */
		public function WorldProxy() 
		{
			super(ComponentNames.WORLD, data);
			Debugger.log(this, "Created.");
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Current world definition.
		 */
		public function set worldDefinition(a:WorldVO):void		{ _worldDefinition = a; }
		public function get worldDefinition():WorldVO			{ return _worldDefinition; }
		private var _worldDefinition:WorldVO;
		
		/**
		 * Player definition.
		 */
		public function set playerDefinition(a:PlayerVO):void	{ _playerDefinition = a; }
		public function get playerDefinition():PlayerVO			{ return _playerDefinition; }
		private var _playerDefinition:PlayerVO;
		
		/**
		 * Player ship definition.
		 */
		public function set playerShipDefinition(a:ShipVO):void	{ _playerShipDefinition = a; }
		public function get playerShipDefinition():ShipVO		{ return _playerShipDefinition; }
		private var _playerShipDefinition:ShipVO;
	}

}