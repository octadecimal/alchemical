/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import starling.display.Sprite;
	/**
	 * MovableEntity
	 * @author Dylan Heyes
	 */
	public class MovableEntity extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function MovableEntity() 
		{
			_dynamics = new DynamicsNode();
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Dynamics.
		 */
		public function set dynamics(a:DynamicsNode):void	{ _dynamics = a; }
		public function get dynamics():DynamicsNode			{ return _dynamics; }
		private var _dynamics:DynamicsNode;
	}

}