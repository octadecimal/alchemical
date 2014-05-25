package alchemical.server.util;

/**
 * ...
 * @author Dylan Heyes
 */
class Delays
{
	// Delayed call map
	private var _delayedCalls:Array<DelayedCall>;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		_delayedCalls = [];
	}
	
	
	
	// REQUEST HANDLERS
	// =========================================================================================
	
	/**
	 * Adds a new delayed call.
	 * @param	time
	 * @param	f
	 */
	public function add(time:Float, f:Void->Void):Void
	{
		_delayedCalls.push( { f: f, time: time } );
	}
	
	/**
	 * Updates the delayed calls.
	 * @param	timePassed	Time passed since last update.
	 */
	public function update(timePassed:Float):Void
	{
		var i:Int = _delayedCalls.length - 1;
		
		while(i >= 0)
		{
			_delayedCalls[i].time -= timePassed;
			
			if (_delayedCalls[i].time <= 0)
			{
				_delayedCalls[i].f();
				
				_delayedCalls.splice(i, 1);
			}
			
			i--;
		}
	}
	
}

// Delay
typedef DelayedCall = {
	var f:Void->Void;
	var time:Float;
}