/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.model 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
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
			Debugger.log(this, "Created.");
		}
	}
}