package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Menu extends FlxState
	{
		
		override public function create():void
		{
			FlxG.switchState(new Map(0));
		}
	}
}