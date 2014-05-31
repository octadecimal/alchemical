/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model.vo 
{
	/**
	 * ShipVO
	 * @author Dylan Heyes
	 */
	public class ShipVO 
	{
		public var id:int;
		public var type:int;
		public var hull:ShipHullVO;
		public var engines:Vector.<ShipEngineVO>;
		
		public function ShipVO(id:int = -1, type:int = -1, hull:ShipHullVO = null, engines:Vector.<ShipEngineVO> = null)
		{
			
		}
	}

}