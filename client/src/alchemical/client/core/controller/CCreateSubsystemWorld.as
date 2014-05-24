/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.model.vo.StartupVO;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.controller.animation.DirectionalAnimationController;
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.mediator.WorldMediator;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.Sky;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.core.Starling;
	
	/**
	 * CCreateSubsystemWorld
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemWorld extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.WORLD);
			
			// Get graphics
			var graphics:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Create world
			var world:World = new World();
			var proxy:WorldProxy = new WorldProxy(); 
			facade.registerProxy(proxy);
			facade.registerMediator(new WorldMediator(world));
			
			// Create sky
			world.sky = new Sky();
			world.addChild(world.sky.view);
			
			// Create camera
			world.camera = new Camera();
			proxy.animationControllers.push(new DirectionalAnimationController(world.camera));
			world.camera.viewport = graphics.viewPort;
			
			Debugger.log(this, "Created: " + ComponentNames.WORLD);
			commandComplete();
		}
	}

}