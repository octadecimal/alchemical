/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
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
			super(ComponentNames.WORLD);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}