/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model.vo 
{
	/**
	 * TextureVO
	 * @author Dylan Heyes
	 */
	public class TextureVO 
	{
		private static var _uid_counter:uint = 0;
		
		public var id:uint;
		public var name:String;
		public var subtexture:String;
		public var atlas:String;
		
		public function TextureVO(name:String, subtexture:String, atlas:String = null) 
		{
			this.id = _uid_counter++;
			this.name = name;
			this.subtexture = subtexture;
			this.atlas = atlas;
		}
		
	}

}