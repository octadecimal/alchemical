/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.Network;
	
	/**
	 * NetworkMediator
	 * @author Dylan Heyes
	 */
	public class NetworkMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function NetworkMediator(viewComponent:Network) 
		{
			super(ComponentNames.NETWORK, viewComponent);
			Debugger.log(this, "Created.");
		}
		
	}

}