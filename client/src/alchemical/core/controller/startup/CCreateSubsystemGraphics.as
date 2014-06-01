/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.game.Game;
	import alchemical.core.enum.ComponentNames;
	import alchemical.core.model.vo.StartupVO;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.graphics.mediator.GraphicsMediator;
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
			if(CONFIG::debug) Debugger.info(this, "Creating subsystem: " + ComponentNames.GRAPHICS);
			
			var starlingContextCreated:Boolean = false;
			var starlingRootCreated:Boolean = false;
			
			// Get flash stage
			var startupVO:StartupVO = notification.getBody() as StartupVO;
			
			// Create starling
			var starling:Starling = new Starling(Game, startupVO.nativeStage);
			
			// Start starling
			starling.showStats = true;
			starling.stage.color = 0x141414;
			starling.start();
			
			// Register
			facade.registerMediator(new GraphicsMediator(starling));
			
			// Listen for context created
			starling.addEventListener(Event.CONTEXT3D_CREATE, function onContextCreated(e:Event):void
			{
				if (CONFIG::debug) Debugger.log(this, "Starling 3d context created.");
				starlingContextCreated = true;
				
				if (starlingContextCreated && starlingRootCreated)
				{
					commandComplete();
				}
			});
			
			// Listen for game created
			starling.addEventListener(Event.ROOT_CREATED, function onRootCreated(e:Event):void
			{
				if(CONFIG::debug) Debugger.log(this, "Starling root created.");
				starlingRootCreated = true;
				
				if (starlingContextCreated && starlingRootCreated)
				{
					commandComplete();
				}
			});
		}
		
		override protected function commandComplete():void 
		{
			if(CONFIG::debug) Debugger.info(this, "Subsystem created: " + ComponentNames.GRAPHICS);
			super.commandComplete();
		}
	}

}