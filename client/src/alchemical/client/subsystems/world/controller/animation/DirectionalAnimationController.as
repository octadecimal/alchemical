/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.input.enum.EActions;
	import alchemical.client.subsystems.world.entities.MovableEntity;
	
	/**
	 * CameraAnimationController
	 * @author Dylan Heyes
	 */
	public class DirectionalAnimationController extends ForwardAnimationController
	{
		public function DirectionalAnimationController(entity:MovableEntity)
		{
			super(entity);
		}
		
		override public function update():void 
		{
			var entity:MovableEntity = _entity;
			
			if (_actionDownStates[EActions.MOVE_UP])
			{
				entity.transform.y -= 2;
			}
			
			if (_actionDownStates[EActions.MOVE_DOWN])
			{
				entity.transform.y += 2;
			}
			
			if (_actionDownStates[EActions.MOVE_LEFT])
			{
				entity.transform.x -= 2;
			}
			
			if (_actionDownStates[EActions.MOVE_RIGHT])
			{
				entity.transform.x += 2;
			}
		}
	}

}