/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.debug.Debugger;
	import starling.display.Sprite;
	
	/**
	 * World
	 * @author Dylan Heyes
	 */
	public class World extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function World() 
		{
			super();
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * World sky.
		 */
		public function set sky(a:Sky):void		{ _sky = a; }
		public function get sky():Sky			{ return _sky; }
		private var _sky:Sky;
	}

}