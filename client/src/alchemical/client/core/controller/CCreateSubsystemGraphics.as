/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.game.Game;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.graphics.mediator.GraphicsMediator;
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.core.Starling;
	import starling.events.Event;
	
	/**
	 * CCreateSubsystemGraphics
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemGraphics extends AsyncCommand
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating subsystem: " + ComponentNames.GRAPHICS);
			
			var starlingContextCreated:Boolean = false;
			var starlingRootCreated:Boolean = false;
			
			// Get flash stage
			var flashStage:Stage = notification.getBody() as Stage;
			
			// Create starling
			var starling:Starling = new Starling(Game, flashStage);
			
			// Start starling
			starling.showStats = true;
			starling.stage.color = 0x000000;
			starling.start();
			
			// Register
			facade.registerMediator(new GraphicsMediator(starling));
			
			// Listen for context created
			starling.addEventListener(Event.CONTEXT3D_CREATE, function onContextCreated(e:Event):void
			{
				Debugger.log(this, "Starling 3d context created.");
				starlingContextCreated = true;
				
				if (starlingContextCreated && starlingRootCreated)
				{
					commandComplete();
				}
			});
			
			// Listen for game created
			starling.addEventListener(Event.ROOT_CREATED, function onRootCreated(e:Event):void
			{
				Debugger.log(this, "Starling root created.");
				starlingRootCreated = true;
				
				if (starlingContextCreated && starlingRootCreated)
				{
					commandComplete();
				}
			});
		}
		
		override protected function commandComplete():void 
		{
			Debugger.log(this, "Subsystem created: " + ComponentNames.GRAPHICS);
			super.commandComplete();
		}
	}

}