/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.enum.EWorldScale;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.World;
	import flash.geom.Rectangle;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CDefineWorld
	 * @author Dylan Heyes
	 */
	public class CDefineWorld extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:WorldVO = notification.getBody() as WorldVO;
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			worldProxy.worldDefinition = vo;
			
			world.worldBounds = new Rectangle(0, 0, vo.width * EWorldScale.UNIT_SIZE, vo.height * EWorldScale.UNIT_SIZE);
			
			Debugger.log(this, "Defined world. id=" + vo.id + " name=" + vo.name + " layers="+vo.skyLayers);
		}
	}

}