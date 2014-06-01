/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.game.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * GameProxy
	 * @author Dylan Heyes
	 */
	public class GameProxy extends Proxy 
	{
		/**
		 * Constructor.
		 * @param	data
		 */
		public function GameProxy(data:Object=null) 
		{
			super(ComponentNames.GAME, data);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
	}
}