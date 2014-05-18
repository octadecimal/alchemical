/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.audio.AudioPlayer;
	import alchemical.client.subsystems.audio.mediator.AudioMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemAudio
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemAudio extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.AUDIO);
			
			facade.registerMediator(new AudioMediator(new AudioPlayer()));
			
			Debugger.log(this, "Created: " + ComponentNames.AUDIO);
			commandComplete();
		}
	}

}