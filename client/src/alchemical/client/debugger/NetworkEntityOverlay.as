/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger 
{
	import alchemical.client.subsystems.world.model.TransformNode;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * NetworkEntityOverlay
	 * @author Dylan Heyes
	 */
	public class NetworkEntityOverlay extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function NetworkEntityOverlay() 
		{
			super();
		}
		
		
		
		
		// API
		// =========================================================================================
		
		public function updateEntity(id:int, transform:TransformNode):void
		{
			var overlay:Quad = getEntityOverlay(id);
			overlay.x = transform.x;
			overlay.y = transform.y;
			overlay.rotation = transform.rotation;
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function getEntityOverlay(id:int):Quad
		{
			if (_entityOverlays[id] == null)
			{
				var quad:Quad = new Quad(100, 50, 0xFF0000);
				quad.pivotX = 50;
				quad.pivotY = 25;
				quad.alpha = 0.35;
				addChild(quad);
				
				_entityOverlays[id] = quad;
			}
			
			return _entityOverlays[id];
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _entityOverlays:Vector.<Quad> = new Vector.<Quad>(20);
	}

}