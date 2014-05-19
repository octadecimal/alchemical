/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world 
{
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Sky
	 * @author Dylan Heyes
	 */
	public class Sky extends Sprite 
	{
		
		public function Sky() 
		{
			super();
			
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
				addChild(_layers[index]);
			}
			else
			{
				_layers[index].texture = texture;
			}
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _layers:Vector.<SkyLayer>;
	}

}