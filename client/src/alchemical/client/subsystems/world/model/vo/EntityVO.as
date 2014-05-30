/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model.vo 
{
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
	/**
	 * EntityVO
	 * @author Dylan Heyes
	 */
	public class EntityVO 
	{
		public var id:int;
		public var transform:TransformNode;
		public var dynamics:DynamicsNode;
		
		public function EntityVO(id:int, transform:TransformNode = null, dynamics:DynamicsNode = null) 
		{
			this.id = id;
			this.transform = transform;
			this.dynamics = dynamics;
		}
		
	}

}