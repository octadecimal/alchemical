/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world 
{
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.entities.Entity;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	
	/**
	 * Sky
	 * @author Dylan Heyes
	 */
	public class Sky extends Entity 
	{
		
		public function Sky(view:Sprite = null) 
		{
			super(view);
			
			refresh(4);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function refresh(numLayers:uint):void
		{
			_layers = new Vector.<SkyLayer>(numLayers);
		}
		
		public function setLayerAt(index:uint, texture:Texture):void 
		{
			if (_layers[index] == null)
			{
				_layers[index] = new SkyLayer(texture);
				view.addChild(_layers[index]);
			}
			else
			{
				_layers[index].texture = texture;
			}
		}
		
		override public function project(camera:Camera):void
		{
			var layer:SkyLayer;
			
			for (var i:int = 0; i < _layers.length; i++)
			{
				if (_layers[i])
				{
					_layers[i].scrollX = (camera.transform.x * ((i*.1)+.025));
					_layers[i].scrollY = (camera.transform.y * ((i*.1)+.025));
				}
			}
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _layers:Vector.<SkyLayer>;
	}

}