package alchemical.server.test;
import alchemical.server.physics.Physics;
import alchemical.server.Server.DynamicEntity;
import alchemical.server.Server.DynamicsNode;
import alchemical.server.Server.TransformNode;
import alchemical.server.util.Debugger;
import haxe.Timer;
import neko.Lib;

/**
 * ...
 * @author Dylan Heyes
 */
class Tests
{
	/**
	 * Constructor
	 */
	public function new() 
	{
		
	}
	
	public function testPhysicsStepping(numEntities:Int, physics:Physics, timePassed:Float):Void
	{
		var entities:Array<DynamicEntity> = [];
		var endTime:Float;
		
		// Generate entities
		for (i in 0...numEntities)
		{
			entities.push(generateRandomEntity(i));
		}
		
		// Step physics
		var startTime:Float = Timer.stamp();
		physics.step(entities, timePassed);
		var endTime:Float = Timer.stamp();
		var totalTime:Float = (endTime - startTime) * 100;
		
		Lib.println("START: " + startTime);
		Lib.println("END:   " + endTime);
		Lib.println("TOTAL: " + totalTime);
		Debugger.info("PHYSICS: " + numEntities + " entities in " + totalTime + " ms.");
	}
	
	private function generateRandomEntity(id:Int):DynamicEntity
	{
		var transform:TransformNode = {
			x: Math.random() * 1920,
			y: Math.random() * 1080,
			r: Math.random() * Math.PI,
		}
		
		var destination:TransformNode = {
			x: Math.random() * 1920,
			y: Math.random() * 1080,
			r: Math.random() * Math.PI,
		}
		
		var dynamics:DynamicsNode = {
			mass: 1,
			thrust: 3,
			torque: 0.5,
			acceleration: 0,
			angularAcceleration: 0,
			vx: 0,
			vy: 0
		}
		
		var entity:DynamicEntity = {
			id: id, 
			world: 0,
			transform: transform,
			dynamics: dynamics,
			state: 0,
			destination: destination 
		}
		
		return entity;
	}
	
}