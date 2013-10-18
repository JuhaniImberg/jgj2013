package jgj.engine 
{
	import flash.display.Sprite;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Map extends Sprite
	{
		
		private var collisionMap:FlxTilemap;
		
		public function Map() 
		{
			collisionMap = new FlxTilemap();
		}
		
	}

}