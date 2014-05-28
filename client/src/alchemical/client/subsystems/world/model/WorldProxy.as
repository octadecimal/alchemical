package alchemical.client.subsystems.world.model
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
	import alchemical.client.subsystems.world.entities.DynamicEntity;
	import alchemical.client.subsystems.world.entities.Entity;
	import alchemical.client.subsystems.world.model.vo.NPCVo;
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
		// Storage for all entities
		private var _entities:Vector.<Entity>;
		
		// Storage for all dynamic entities
		private var _dynamicEntities:Vector.<DynamicEntity>;
		
		// Storage for all static entities
		private var _staticEntities:Vector.<Entity>;
		
		
		/**
		 * Consturctor.
		 */
		public function WorldProxy() 
		{
			super(ComponentNames.WORLD, data);
			
			_entities = new Vector.<Entity>();
			_dynamicEntities = new Vector.<DynamicEntity>();
			_staticEntities = new Vector.<Entity>;
			
			Debugger.log(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function registerEntity(entity:DynamicEntity):void
		{
			_entities.push(entity);
			
			if (entity.dynamics)
			{
				_dynamicEntities.push(entity);
			}
			else
			{
				_staticEntities.push(entity);
			}
			
			Debugger.log(this, "Entity registered: " + entity.id);
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
		
		/**
		 * NPC definitions.
		 */
		public function set npcDefinitions(a:Vector.<NPCVo>):void	{ _npcDefinitions = a; }
		public function get npcDefinitions():Vector.<NPCVo>		{ return _npcDefinitions; }
		private var _npcDefinitions:Vector.<NPCVo>;
	}

}