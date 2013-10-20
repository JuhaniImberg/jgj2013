package jgj.engine
{
	import flash.desktop.ClipboardTransferMode;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Help extends FlxState
	{
		[Embed(source="../../../assets/box cocer art.png")]
		private var BG_IMG:Class;
		
		override public function create():void
		{
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			var text:FlxText = new FlxText(100, 100, 100);
			text.text = "Help\nGet to the end. Signs with blobs on them should be filled with blobs. Same with boxes for box signs.\nControls\nArrow keys move, space drags";
			text.color = 0xff000000;
			add(text);
			var but2:FlxButton = new FlxButton(100, 480/2, "Back", function():void
				{
					FlxG.switchState(new Menu());
				});
			add(but2);
		}
	}
}