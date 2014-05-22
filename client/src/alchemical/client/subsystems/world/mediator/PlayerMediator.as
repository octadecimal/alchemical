/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.InputNotes;
	import alchemical.client.subsystems.world.entities.Player;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * PlayerMediator
	 * @author Dylan Heyes
	 */
	public class PlayerMediator extends Mediator 
	{
		private var _view:Player;
		
		/**
		 * Constructor.
		 * @param	viewComponent	Player instance.
		 */
		public function PlayerMediator(viewComponent:Player) 
		{
			_view = Player(viewComponent);
			super(ComponentNames.PLAYER, viewComponent);
			
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			interests.push(InputNotes.KEY_DOWN);
			interests.push(InputNotes.KEY_UP);
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case(InputNotes.KEY_DOWN):
					//if (_view.animationController)
						_view.animationController.handleKeyDown(uint(notification.getBody()));
					break;
				
				case(InputNotes.KEY_UP):
					//if (_view.animationController)
						_view.animationController.handleKeyUp(uint(notification.getBody()));
					break;
			}
			
			super.handleNotification(notification);
		}
	}

}