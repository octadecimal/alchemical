/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.input.model.vo 
{
	/**
	 * MouseVO
	 * @author Dylan Heyes
	 */
	public class MouseVO 
	{
		public var x:Number;
		public var y:Number;
		public var delta:Number;
		
		public function MouseVO(x:Number = 0, y:Number = 0, delta:int = 0) 
		{
			this.x = x;
			this.y = y;
			this.delta = delta;
		}
		
	}

}