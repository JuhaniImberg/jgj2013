package jgj.engine
{
	
	import flash.display.Sprite;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Engine extends Sprite
	{
		
		private var kenttä:Map;
		
		public function Engine()
		{
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			
			kenttä = new Map();
		}
	
	}

}