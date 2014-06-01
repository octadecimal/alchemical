/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.tests 
{
	import alchemical.debug.Debugger;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * DebugTestCase
	 * @author Dylan Heyes
	 */
	public class CDebugTestCase extends AsyncCommand
	{
		public var name:String;
		
		override public function execute(notification:INotification):void 
		{
			super.execute(notification);
			
			if (CONFIG::debug) Debugger.info(this, "Running test: " + name);
		}
		
		public function pass():void
		{
			if (CONFIG::debug) Debugger.log(this, "Passed: "+name);
			commandComplete();
		}
		
		public function fail():void
		{
			if (CONFIG::debug) Debugger.error(this, "Fail: "+name);
		}
	}

}