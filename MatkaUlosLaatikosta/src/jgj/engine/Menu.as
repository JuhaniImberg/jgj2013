package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Menu extends FlxState
	{
		[Embed(source="../../../assets/auto_tiles.png")]
		private static var auto_tiles:Class;
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var default_auto:Class;
		
		override public function create():void
		{
			FlxG.switchState(new Map(default_auto, auto_tiles, 16, 16));
		}
	}
}