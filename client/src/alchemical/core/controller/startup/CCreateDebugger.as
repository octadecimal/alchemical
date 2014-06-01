/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.model.vo.StartupVO;
	import alchemical.debug.Debugger;
	import alchemical.debug.mediator.DebuggerMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateDebugger
	 * @author Dylan Heyes
	 */
	public class CCreateDebugger extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var vo:StartupVO = notification.getBody() as StartupVO;
			
			var debugger:Debugger = new Debugger();
			facade.registerMediator(new DebuggerMediator(debugger));
			
			// Add overlay to native stage
			vo.nativeStage.addChild(debugger.overlay);
			
			// Resize debug overlay to stage width
			debugger.overlay.resize(vo.nativeStage.stageWidth, vo.nativeStage.stageHeight);
			
			// Show debug overlay
			debugger.overlay.show();
			
			commandComplete();
		}
	}

}