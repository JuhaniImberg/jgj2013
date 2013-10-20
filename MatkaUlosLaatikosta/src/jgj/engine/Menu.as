package jgj.engine
{
	import flash.desktop.ClipboardTransferMode;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Menu extends FlxState
	{
		[Embed(source="../../../assets/box cocer art.png")]
		private var BG_IMG:Class;
		
		[Embed(source = "../../../assets/menu.mp3")]
		private var bgm:Class;
		
		override public function create():void
		{
			FlxG.playMusic(bgm);
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			var but:FlxButton = new FlxButton(100, 480/2-24, "Start", function():void
				{
					FlxG.mouse.hide();
					FlxG.switchState(new Map(0));
				});
			add(but);
			var but2:FlxButton = new FlxButton(100, 480/2, "Help", function():void
				{
					FlxG.switchState(new Help());
				});
			add(but2);
			
			FlxG.mouse.show();
			
			//FlxG.switchState(new Map(0));
		}
	}
}