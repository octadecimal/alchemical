/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import alchemical.client.subsystems.world.model.vo.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CDefineWorld
	 * @author Dylan Heyes
	 */
	public class CDefineWorld extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:WorldVO = notification.getBody() as WorldVO;
			
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			worldProxy.worldDefinition = vo;
			
			commandComplete();
		}
	}

}