package jgj.engine
{
	import org.flixel.*;
	
	[SWF(width = "640", height = "480", backgroundColor = "#FBFBFB")]
	[Frame(factoryClass="jgj.engine.Preloader")]
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Engine extends FlxGame
	{
		
		public function Engine():void
		{
			super(3.2*320, 2*240, Menu, 1);
			
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			
		}
	
	}

}