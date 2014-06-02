/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model.vo 
{
	/**
	 * TextureAtlasVO
	 * @author Dylan Heyes
	 */
	public class TextureAtlasVO 
	{
		public var id:int;
		public var texture:String
		public var loaded:Boolean;
		
		public function TextureAtlasVO(id:int, texture:String) 
		{
			this.id = id;
			this.texture = texture;
		}
		
	}

}