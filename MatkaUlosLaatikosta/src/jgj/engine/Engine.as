package jgj.engine
{
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Engine extends FlxGame
	{
		
		public function Engine()
		{
			super(320,240,Map,2);
			
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
		}
	
	}

}