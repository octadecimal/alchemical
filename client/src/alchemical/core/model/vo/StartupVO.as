/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.model.vo 
{
	import flash.display.Stage;
	
	/**
	 * StartupVO
	 * @author Dylan Heyes
	 */
	public class StartupVO 
	{
		public var nativeStage:Stage;
		//public var gateway:INetworkGateway;
		
		public function StartupVO(nativeStage:Stage/*, gateway:INetworkGateway*/) 
		{
			this.nativeStage = nativeStage;
			//this.gateway = gateway;
		}
		
	}

}