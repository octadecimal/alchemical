/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.model.vo.PlayerVO;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDefinePlayer
	 * @author Dylan Heyes
	 */
	public class CDefinePlayer extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:PlayerVO = notification.getBody() as PlayerVO;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			worldProxy.playerDefinition = vo;
			
			Debugger.log(this, "Defined player. id=" + vo.id + " name=" + vo.name);
		}
	}

}