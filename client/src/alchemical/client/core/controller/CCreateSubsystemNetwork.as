/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.mediator.NetworkMediator;
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
			
			facade.registerMediator(new NetworkMediator(new Network()));
			
			Debugger.log(this, "Created: " + ComponentNames.NETWORK);
			commandComplete();
		}
	}

}