package jgj.engine
{
	
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Box extends FlxSprite
	{
		
		[Embed(source="../../../assets/laatikkotile.png")]
		private var BOX_IMG:Class;
		
		private var fall:Boolean;
		private var parent:EntityManager;
		public var type:String = "box";
		public var ar:FlxPoint;
		
		private var kivi_tmp:Boolean = false;
		
		public function Box(par:EntityManager, x:Number, y:Number):void
		{
			parent = par;
			super(x, y);
			loadGraphic(BOX_IMG);
			width = 32;
			height = 32;
			offset.x = 0;
			offset.y = 0;
			drag.x = 640;
			acceleration.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 300;
			ar = new FlxPoint(0, 0);
		}
		
		override public function update():void
		{
			this.acceleration.x = ar.x;
			
			ar.x = 0;
			super.update();
			
			if (Math.abs(this.velocity.x) > 1 && isTouching(FLOOR))
			{
				parent.emit(x + (width / 2) - (width / 4), y + height, 0, 1);
				parent.emit(x + (width / 2), y + height, 0, 1);
				parent.emit(x + (width / 2) + (width / 4), y + height, 0, 1);
			}
		
		}
	}
}