package jgj.engine
{
	import org.flixel.*;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass="jgj.engine.Preloader")]
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Engine extends FlxGame
	{
		
		public function Engine():void
		{
			super(640, 480, Menu, 1);
			
			FlxG.worldBounds = new FlxRect(0, 0, 32 * 32, 32 * 32);
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			
		}
	
	}

}