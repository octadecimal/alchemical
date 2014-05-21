/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world 
{
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
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
			
			// Temp
			addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			for (var i:int = 0; i < _layers.length; i++)
			{
				if (_layers[i])
				{
					if (i == 0)
					{
						_layers[i].scrollX += 0.01;
						_layers[i].scrollY += 0.01;
					}
					//else if (i == _layers.length - 1)
					//{
						//_layers[i].scrollX += (_layers.length - i) * 0.75;
						//_layers[i].scrollY += (_layers.length - i) * 0.75;
					//}
					else
					{
						_layers[i].scrollX += (i+1) * 0.05;
						_layers[i].scrollY += (i+1) * 0.05;
					}
				}
			}
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