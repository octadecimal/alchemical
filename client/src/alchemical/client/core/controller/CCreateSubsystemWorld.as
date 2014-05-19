/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.Camera;
	import alchemical.client.subsystems.world.mediator.WorldMediator;
	import alchemical.client.subsystems.world.proxy.WorldProxy;
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
			
			var view:World = new World();
			view.sky = new Sky();
			view.camera = new Camera();
			
			view.addChild(view.sky);
			
			facade.registerProxy(new WorldProxy());
			facade.registerMediator(new WorldMediator(view));
			
			Debugger.log(this, "Created: " + ComponentNames.WORLD);
			commandComplete();
		}
	}

}