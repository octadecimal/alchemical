/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.util 
{
	/**
	 * StringUtils
	 * @author Dylan Heyes
	 */
	public class StringUtils 
	{
		static public function toFixedPrefix(input:*, prefix:String, outputLength:int):String
		{
			var output:String = "";
			
			for (var i:int = 0, c:int = outputLength - input.toString().length; i < c; i++)
			{
				output += prefix;
			}
			
			return output + input;
		}
	}

}