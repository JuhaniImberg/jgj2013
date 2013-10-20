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
		
		override public function create():void
		{
			var bg:FlxSprite = new FlxSprite(0, 0, BG_IMG);
			add(bg);
			var but:FlxButton = new FlxButton(100, 480/2-24, "Start", function():void
				{
					FlxG.mouse.hide();
					FlxG.switchState(new Map(0));
				});
			add(but);
			
			FlxG.mouse.show();
			
			FlxG.switchState(new Map(0));
		}
	}
}