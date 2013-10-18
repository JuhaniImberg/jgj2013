package jgj.engine 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Map extends FlxState
	{
		
		private var collisionMap:FlxTilemap;
		
		public function Map() 
		{
			collisionMap = new FlxTilemap();
		}
		
	}

}