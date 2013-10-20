package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Credits extends FlxState
	{
		[Embed(source="../../../assets/box cocer art.png")]
		private var BG_IMG:Class;
		
		override public function create():void
		{
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			
			var text:FlxText = new FlxText(0, 480 / 2 - 50, 300, "Credits\n\nJuhani Imberg - Coding\nNicklas Ahlskog - Coding\n");
			text.color = 0xff000000;
			text.alignment = "right";
			text.size = 16;
			add(text);
		}
	}
}