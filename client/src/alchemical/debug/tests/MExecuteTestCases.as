/**
 * alchemical.debug.testses
 */
package alchemical.debug.tests 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MExecuteTestCases
	 * @author Dylan Heyes
	 */
	public class MExecuteTestCases extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CDebugTestCase_VerifySubsystemCreation);
		}
	}

}