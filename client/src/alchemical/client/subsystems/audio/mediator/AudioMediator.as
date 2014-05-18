/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.audio.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.audio.AudioPlayer;
	
	/**
	 * AudioMediator
	 * @author Dylan Heyes
	 */
	public class AudioMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent	Audio player.
		 */
		public function AudioMediator(viewComponent:AudioPlayer) 
		{
			super(ComponentNames.AUDIO, viewComponent);
			Debugger.log(this, "Created.");
		}
		
	}

}