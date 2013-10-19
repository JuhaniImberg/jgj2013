package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Menu extends FlxState
	{
		[Embed(source="../../../assets/tileset0.png")]
		private static var auto_tiles:Class;
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var default_auto:Class;
		
		override public function create():void
		{
						trace("asd");

			FlxG.switchState(new Map(default_auto, auto_tiles, 32, 32));
		}
	}
}