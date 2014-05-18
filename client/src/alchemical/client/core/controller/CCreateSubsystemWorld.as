/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.mediator.WorldMediator;
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
			
			facade.registerMediator(new WorldMediator(new World()));
			
			Debugger.log(this, "Created: " + ComponentNames.WORLD);
			commandComplete();
		}
	}

}