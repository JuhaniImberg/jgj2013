package jgj.engine
{
	import mx.core.FlexSprite;
	import org.flixel.*;
	
	public class Blob extends FlxSprite
	{
		[Embed(source="../../../assets/moykky.png")]
		private var blob_sprite:Class;
		
		private var pl:Player;
		private var parent:EntityManager;
		public var type:String = "blob";
		
		public function Blob(par:EntityManager, x:int, y:int, p:Player):void
		{
			parent = par;
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
			
			addAnimation("idle", [0, 1], 2);
			addAnimation("run", [0, 1], 2);
			addAnimation("jump", [0, 1], 2);
			
			/*line = new FlxSprite(x, y);
			   line.makeGraphic(256, 256, 0xff000000);
			   line.solid = false;
			 parent.add(line);*/
			
			color = Math.min(1, FlxG.random() + 0.7) * 0xff + Math.min(1, FlxG.random() + 0.7) * 0xff00 + Math.min(1, FlxG.random() + 0.7) * 0xff0000;
		
		}
		
		override public function draw():void
		{
			super.draw();
		}
		
		override public function update():void
		{
			var target:Number;
			this.acceleration.x = 0;
			
			if (pl.facing == FlxObject.RIGHT)
			{
				target = pl.x + pl.width + 32;
			}
			else
			{
				target = pl.x - 32 - width;
			}
			
			if (x < target)
			{
				this.acceleration.x += 75 + Math.random() * 150;
				this.facing = FlxObject.RIGHT;
			}
			else if (x > target)
			{
				this.acceleration.x -= 75 + Math.random() * 150;
				this.facing = FlxObject.LEFT;
			}
			
			if (isTouching(FLOOR))
			{
				this.velocity.y = -100 - Math.random() * 200;
				parent.emit(x + (width / 2), y + (height), 1, 20);
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
			/*line.x = Math.min(pl.x, x);
			   line.y = Math.min(pl.y, y);
			   line.fill(0x00000000);
			 line.drawLine(0, 0, x-(pl.x), y-(line.y - pl.y), 0xff000000, 1);*/
			super.update();
		}
	}
}