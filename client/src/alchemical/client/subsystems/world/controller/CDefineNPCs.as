/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.model.vo.NPCVo;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDefineNPCs
	 * @author Dylan Heyes
	 */
	public class CDefineNPCs extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vos:Vector.<NPCVo> = notification.getBody() as Vector.<NPCVo>;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			worldProxy.npcDefinitions = vos;
			
			Debugger.log(this, "Defined NPCs. total=" + vos.length);
		}
	}

}