/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model 
{
	/**
	 * TransformNode
	 * @author Dylan Heyes
	 */
	public class TransformNode 
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var rotation:Number = 0;
		
		public function TransformNode(x:Number = 0, y:Number = 0, rotation:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.rotation = rotation;
		}
	}

}