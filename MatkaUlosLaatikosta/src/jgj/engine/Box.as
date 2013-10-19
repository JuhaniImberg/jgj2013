package jgj.engine
{
	
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Box extends FlxSprite
	{
		
		private var fall:Boolean;
		private var parent:EntityManager;
		
		public function Box(par:EntityManager, x:Number, y:Number):void
		{
			parent = par;
			super(x, y);
			//loadGraphic(box_0, false, false, 32, 32);
			makeGraphic(32, 32, 0xFF8B4C39);
			width = 32;
			height = 32;
			offset.x = 0;
			offset.y = 0;
			drag.x = 640;
			acceleration.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 300;
		}
		
		override public function update():void
		{
			super.update();
			if (isTouching(FLOOR))
			{
				this.velocity.y = 0;
			}
			
		}
	}
}