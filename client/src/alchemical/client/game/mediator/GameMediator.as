/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.Game;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * GameMediator
	 * @author Dylan Heyes
	 */
	public class GameMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function GameMediator(viewComponent:Game) 
		{
			super(ComponentNames.GAME, viewComponent);	
			Debugger.log(this, "Created.");
		}
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			
			
			return interests;
		}
	}

}