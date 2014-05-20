/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model.vo 
{
	/**
	 * WorldVO
	 * @author Dylan Heyes
	 */
	public class WorldVO 
	{
		public var id:int;
		public var name:String;
		public var width:int;
		public var height:int;
		public var numSkyLayers:int;
		public var skyLayers:Vector.<int> = new Vector.<int>();
	}

}