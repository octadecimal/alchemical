/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.proxy 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
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
		public function set worldDefinition(a:WorldVO):void	{ _worldDefinition = a; }
		public function get worldDefinition():WorldVO		{ return _worldDefinition; }
		private var _worldDefinition:WorldVO;
	}

}