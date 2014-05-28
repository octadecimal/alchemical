/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model.vo 
{
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
	import alchemical.client.subsystems.world.model.vo.VesselVO;
	
	/**
	 * NetworkEntityVO
	 * @author Dylan Heyes
	 */
	public class NetworkEntityVO 
	{
		public var id:int;
		public var type:int;
		public var transform:TransformNode;
		public var dynamics:DynamicsNode;
		public var vessel:VesselVO;
		
		public function NetworkEntityVO(id:int, type:int, transform:TransformNode = null, dynamics:DynamicsNode) 
		{
			this.id = id;
			this.type = type;
			this.transform = transform;
			this.dynamics = dynamics;
		}
		
	}

}