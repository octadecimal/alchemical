/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.debugger.WorldStats;
	import alchemical.client.subsystems.network.model.NetworkProxy;
	import alchemical.client.subsystems.world.entities.Player;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDebugUpdateWorldStats
	 * @author Dylan Heyes
	 */
	public class CDebugUpdateWorldStats extends SimpleCommand 
	{		
		override public function execute(notification:INotification):void 
		{
			var debugger:Debugger = facade.retrieveMediator(ComponentNames.DEBUGGER).getViewComponent() as Debugger;
			var stats:WorldStats = debugger.worldStats;
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var player:Player = facade.retrieveMediator(ComponentNames.PLAYER).getViewComponent() as Player;
			
			var networkProxy:NetworkProxy = facade.retrieveProxy(ComponentNames.NETWORK) as NetworkProxy;
			
			stats.updateNetworkBandwidth(networkProxy.inBytesPerSecond, networkProxy.outBytesPerSecond);
			stats.updateWorld(world);
			stats.updateCamera(world.camera);
			stats.updatePlayer(player);
		}		
	}

}