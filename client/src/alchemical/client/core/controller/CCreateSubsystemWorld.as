/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.controller.animation.DirectionalAnimationController;
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.mediator.WorldMediator;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.Sky;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemWorld
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemWorld extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.WORLD);
			
			// Create world
			var view:World = new World();
			var proxy:WorldProxy = new WorldProxy(); 
			facade.registerProxy(proxy);
			facade.registerMediator(new WorldMediator(view));
			
			// Create sky
			view.sky = new Sky();
			view.addChild(view.sky);
			
			// Create camera
			view.camera = new Camera();
			proxy.animationControllers.push(new DirectionalAnimationController(view.camera));
			
			Debugger.log(this, "Created: " + ComponentNames.WORLD);
			commandComplete();
		}
	}

}