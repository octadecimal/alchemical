/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * MUpdateAnimationControllers
	 * @author Dylan Heyes
	 */
	public class CUpdateAnimationControllers extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			
			var animationControllers:Vector.<AnimationController> = worldProxy.animationControllers;
			
			for (var i:int = animationControllers.length - 1; i >= 0; i--)
			{
				animationControllers[i].update();
			}
		}
	}

}