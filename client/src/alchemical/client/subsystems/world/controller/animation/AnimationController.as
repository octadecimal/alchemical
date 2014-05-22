/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.world.entities.MovableEntity;
	/**
	 * AnimationController
	 * @author Dylan Heyes
	 */
	public class AnimationController 
	{
		protected var _entity:MovableEntity;
		
		public function AnimationController(entity:MovableEntity) 
		{
			_entity = entity;
		}
		
		public function update():void
		{
			
		}
	}

}