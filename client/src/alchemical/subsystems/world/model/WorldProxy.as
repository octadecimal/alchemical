/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.model.vo.ships.ShipHullVO;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * WorldProxy
	 * @author Dylan Heyes
	 */
	public class WorldProxy extends Proxy 
	{
		/**
		 * Constructor.
		 */
		public function WorldProxy() 
		{
			_shipHullDefinitions = new Vector.<ShipHullVO>();
			
			super(ComponentNames.WORLD);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Raw ship definitions xml.
		 */
		public function set shipDefinitionsData(a:XML):void					{ _shipDefinitionsData = a; }
		public function get shipDefinitionsData():XML						{ return _shipDefinitionsData; }
		private var _shipDefinitionsData:XML;
		
		/**
		 * Ship hull definitions.
		 */
		public function get shipHullDefinitions():Vector.<ShipHullVO>		{ return _shipHullDefinitions; }
		private var _shipHullDefinitions:Vector.<ShipHullVO>;
	}

}