package jgj.engine
{
	import org.flixel.*;
	
	[SWF(width="640",height="480",backgroundColor="#000000")]
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Engine extends FlxGame
	{
		[Embed(source="../../../assets/auto_tiles.png")]
		private static var auto_tiles:Class;
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var default_auto:Class;
		
		public function Engine():void
		{
			super(320, 240, FlxState, 2);
			
			FlxG.framerate = 30;
			FlxG.flashFramerate = 30;
			
			var m:Map = new Map();
			
			FlxG.switchState(m);
			
			m.init(default_auto, auto_tiles, 16, 16);
		}
	
	}

}