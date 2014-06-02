/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.core.notifications.WorldNotifications;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.world.SkyLayer;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.EnterFrameEvent;
	
	/**
	 * WorldMediator
	 * @author Dylan Heyes
	 */
	public class WorldMediator extends Mediator 
	{
		private var _view:World;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function WorldMediator(viewComponent:World) 
		{
			_view = viewComponent;
			super(ComponentNames.WORLD, viewComponent);
			if (CONFIG::debug) Debugger.data(this, "Created.");
			
			_view.addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
			
			_view.sigSkyLayerDisposed.add(onSkyLayerDisposed);
		}
		
		
		
		// SIGNALS
		// =========================================================================================
		
		private function onSkyLayerDisposed(skyLayer:SkyLayer):void 
		{
			if (CONFIG::debug) Debugger.log(this, "SKY LAYER DISPOSED YO BRO: " + skyLayer);
			
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			
			resourcesProxy.undeclareSkyTexture(skyLayer);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			sendNotification(WorldNotifications.UDPATE_WORLD, e.passedTime);
		}
		
	}

}