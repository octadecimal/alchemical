/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model.vo 
{
	/**
	 * ResourceVO
	 * @author Dylan Heyes
	 */
	public class ResourceVO 
	{
		public var id:int;
		public var texture:String;
		public var atlas:String;
		
		public function ResourceVO(id:int, texture:String, atlas:String = null) 
		{
			this.id = id;
			this.texture = texture;
			this.atlas = atlas;
		}
		
	}

}