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
		
		[Embed(source = "../../../assets/credits.mp3")]
		private var bgm:Class;
		
		override public function create():void
		{
			FlxG.playMusic(bgm);
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			
			var text:FlxText = new FlxText(0, 480 / 2 - 50, 300, "Credits\n\nCoding\n\n\nGraphics & Music\n\nSound effects\n");
			text.color = 0xff666666;
			text.alignment = "center";
			text.size = 16;
			add(text);
			
			var text2:FlxText = new FlxText(0, 480 / 2 - 50, 300, "\n\n\nJuhani Imberg\nNicklas Ahlskog\n\nJulius Heino\n\nfreesounds.org - fins");
			text2.color = 0xff000000;
			text2.alignment = "center";
			text2.size = 16;
			add(text2);
		}
	}
}