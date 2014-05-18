/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.model.vo 
{
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import flash.display.Stage;
	/**
	 * StartupVO
	 * @author Dylan Heyes
	 */
	public class StartupVO 
	{
		public var nativeStage:Stage;
		public var gateway:INetworkGateway;
		
		public function StartupVO(nativeStage:Stage, gateway:INetworkGateway) 
		{
			this.nativeStage = nativeStage;
			this.gateway = gateway;
		}
		
	}

}