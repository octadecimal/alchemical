package alchemical.server.util;
import alchemical.server.Server.TransformNode;
import haxe.Timer;

/**
 * ...
 * @author Dylan Heyes
 */
class Tweens
{
	/**
	 * Construtor.
	 */
	public function new() 
	{
		_tweens = new Array<Tween>();
	}
	
	
	
	// API
	// =========================================================================================
	
	public function update(timePassed:Float):Void
	{
		var tween:Tween;
		
		var currentTime:Float = Timer.stamp();
		var i:Int = _tweens.length - 1;
		
		while (i > 0)
		{
			tween = _tweens[i];
			
			tween.currentTime = currentTime;
			tween.ratio = (tween.currentTime - tween.startTime) / (tween.endTime - tween.startTime);
			
			if (tween.ratio >= 1)
			{
				_tweens.splice(i, 1);
			}
			
			i--;
		}
	}
	
	public function transform(position:TransformNode, time:Float, x:Float, y:Float):Tween
	{
		var currentTime:Float = Timer.stamp();
		
		var tween:Tween = {
			startTime: currentTime,
			endTime: currentTime + time,
			currentTime: currentTime,
			ratio: 0
		};
		
		trace("TWEEN: start=" + tween.startTime+" endTime=" + tween.endTime);
		
		_tweens.push(tween);
		
		return tween;
	}
	
	
	
	// API
	// =========================================================================================
	
	private var _tweens:Array<Tween>;
}



// Tween
typedef Tween = {
	var startTime:Float;
	var endTime:Float;
	var currentTime:Float;
	var ratio:Float;
}