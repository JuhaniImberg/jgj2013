package jgj.engine
{
	import org.flixel.*;
	
	public class Blob extends FlxSprite
	{
		[Embed(source="../../../assets/moykky.png")]
		private var blob_sprite:Class;
		
		private var pl:Player;
		
		public function Blob(x:int, y:int, p:Player):void
		{
			super(x, y);
			loadGraphic(blob_sprite, true, true, 23, 13);
			pl = p;
			
			width = 23;
			height = 13;
			offset.x = 0;
			offset.y = 0;
			
			drag.x = 640;
			acceleration.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 300;
			
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1], 6);
			addAnimation("jump", [1]);
		
		}
		
		override public function draw():void
		{
			super.draw();
		}
		
		override public function update():void
		{
			this.acceleration.x = 0;
			if (isTouching(FLOOR))
			{
				this.velocity.y = -100;
			}
			
			if (x < pl.x)
			{
				this.acceleration.x = 100;
				this.facing = FlxObject.RIGHT;
			}
			else if (x > pl.x)
			{
				this.acceleration.x = -100;
				this.facing = FlxObject.LEFT;
			}
			else
			{
				
			}
			
			if (this.velocity.y != 0)
			{
				this.play("jump");
			}
			else if (this.velocity.x == 0)
			{
				this.play("idle");
			}
			else
			{
				this.play("run");
			}
			
			super.update();
		}
	}
}