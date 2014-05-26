/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model.vo 
{
	import alchemical.client.subsystems.world.model.TransformNode;
	/**
	 * TransformNodeVO
	 * @author Dylan Heyes
	 */
	public class TransformNodeVO 
	{
		public var id:int;
		public var transform:TransformNode;
		
		public function TransformNodeVO(id:int, transform:TransformNode) 
		{
			this.id = id;
			this.transform = transform;
		}
		
	}

}