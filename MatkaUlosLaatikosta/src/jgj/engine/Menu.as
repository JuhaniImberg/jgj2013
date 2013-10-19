package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Menu extends FlxState
	{
		[Embed(source="../../../assets/box cocer art.png")]
		private var BG_IMG:Class;
		
		override public function create():void
		{
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			//FlxG.switchState(new Map(0));
		}
	}
}