/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.model.vo.StartupVO;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.gateways.SimulatedGateway;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import alchemical.client.subsystems.network.mediator.NetworkMediator;
	import alchemical.client.subsystems.network.model.NetworkProxy;
	import alchemical.client.subsystems.network.Network;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemNetwork
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemNetwork extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.NETWORK);
			
			var startupVO:StartupVO = notification.getBody() as StartupVO;
			
			var gateway:INetworkGateway = startupVO.gateway;
			var network:Network = new Network(gateway);
			
			facade.registerProxy(new NetworkProxy(gateway));
			facade.registerMediator(new NetworkMediator(network));
			
			Debugger.log(this, "Created: " + ComponentNames.NETWORK);
			commandComplete();
		}
	}

}