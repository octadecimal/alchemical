/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network 
{
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	
	/**
	 * Network
	 * @author Dylan Heyes
	 */
	public class Network 
	{
		// Network gateway.
		public var gateway:INetworkGateway;
		
		/**
		 * Constructor.
		 */
		public function Network(gateway:INetworkGateway) 
		{
			this.gateway = gateway;
		}
		
	}

}