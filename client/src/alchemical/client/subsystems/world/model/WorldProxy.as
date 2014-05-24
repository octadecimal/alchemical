package alchemical.client.subsystems.world.model
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
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
		/**
		 * Consturctor.
		 */
		public function WorldProxy() 
		{
			super(ComponentNames.WORLD, data);
			
			_animationControllers = new Vector.<AnimationController>();
			
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
		
		/**
		 * NPC definitions.
		 */
		public function set npcDefinitions(a:Vector.<NPCVo>):void	{ _npcDefinitions = a; }
		public function get npcDefinitions():Vector.<NPCVo>		{ return _npcDefinitions; }
		private var _npcDefinitions:Vector.<NPCVo>;
		
		/**
		 * Animation controllers.
		 */
		public function set animationControllers(a:Vector.<AnimationController>):void	{ _animationControllers = a; }
		public function get animationControllers():Vector.<AnimationController>			{ return _animationControllers; }
		private var _animationControllers:Vector.<AnimationController>;
	}

}