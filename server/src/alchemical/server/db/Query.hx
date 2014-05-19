package alchemical.server.db;

/**
 * ...
 * @author Dylan Heyes
 */
class Query
{
	private var _output:String;
	
	public function new() 
	{
		_output = "";
	}
	
	public function select(value:String):Query
	{
		_output += "SELECT " + value+" ";
		return this;
	}
	
	public function from(table:String):Query
	{
		_output += "FROM alchemical." + table+" ";
		return this;
	}
	
	public function where(condition:String, value:Dynamic):Query
	{
		if (Std.is(value, String))
			value = "'" + value + "'";
		
		_output += "WHERE " + condition + "=" + value + " ";
		
		return this;
	}
	
	public function and(condition:String, value:Dynamic):Query
	{	
		if (Std.is(value, String))
			value = "'" + value + "'";
		
		_output += "AND " + condition + "=" + value+" ";
		
		return this;
	}
	
	public function getQuery():String
	{
		return _output;
	}
	
}