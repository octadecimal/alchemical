/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.enum.NetworkNotes;
	import alchemical.client.subsystems.network.model.NetworkProxy;
	import alchemical.client.subsystems.network.Network;
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * NetworkMediator
	 * @author Dylan Heyes
	 */
	public class NetworkMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function NetworkMediator(viewComponent:Network) 
		{
			super(ComponentNames.NETWORK, viewComponent);
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function onRegister():void
		{
			_proxy = facade.retrieveProxy(ComponentNames.NETWORK) as NetworkProxy;
		}
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			interests.push(NetworkNotes.LOGIN);
			
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.LOGIN:
					handleLoginRequest(notification);
					break;
			}
			
			super.handleNotification(notification);
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleLoginRequest(notification:INotification):void 
		{
			var user:String = notification.getBody().user;
			var pass:String = notification.getBody().pass;
			
			_proxy.writeLoginRequest(user, pass);
			
			Debugger.log(this, "Logging in with: " + user + "," + pass);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		// Allowing acces to proxy within mediator instead of using commands for speed.
		private var _proxy:NetworkProxy;
	}

}