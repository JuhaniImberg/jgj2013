package jgj.engine
{
	
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Player extends FlxSprite
	{
		
		[Embed(source="../../../assets/taapero.png")]
		private var player_sprite_0:Class;
		private var _jump:Number;
		private var parent:EntityManager;
		private var text:FlxText;
		private var timer:Number;
		public var type:String = "player";
		
		public function Player(par:EntityManager, x:Number, y:Number, plid:Number)
		{
			parent = par;
			super(x, y);
			var img:Class;
			switch (plid)
			{
				case 0: 
					img = player_sprite_0;
					break;
				default: 
					break;
			}
			loadGraphic(img, true, true, 22, 44);
			
			//bounding box tweaks
			width = 22;
			height = 44;
			offset.x = 0;
			offset.y = 0;
			
			//basic player physics
			drag.x = 640;
			acceleration.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 300;
			
			//animations
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1], 6);
			addAnimation("jump", [0]);
			
			text = new FlxText(x, y, 64);
			text.text = "";
			text.color = 0xff000000;
			text.alignment = "center";
			parent.add(text);
		
		}
		
		public function addText(te:String, ti:Number):void
		{
			text.text = te;
			timer = ti;
		}
		
		override public function update():void
		{
			if (text.text.length > 0)
			{
				timer -= FlxG.elapsed;
				text.x = x - (width);
				text.y = y - 20;
				if (timer < 0)
				{
					text.text = "";
				}
			}
			
			this.acceleration.x = 0;
			if (FlxG.keys.LEFT)
			{
				this.facing = FlxObject.LEFT;
				this.acceleration.x = -this.drag.x;
			}
			else if (FlxG.keys.RIGHT)
			{
				this.facing = FlxObject.RIGHT;
				this.acceleration.x = this.drag.x;
			}
			
			if (_jump == 0 && FlxG.keys.UP)
			{
				this.velocity.y = -300;
				_jump = 1;
			}
			
			if (FlxG.keys.A)
			{
				addText("Hello world!", 5);
			}
			
			if (FlxG.keys.justPressed("S"))
			{
				this.parent.addBox((this.facing == FlxObject.RIGHT?x + width + 16:x - 32 - 16), y + height - 32);
			}
			
			if (FlxG.keys.justPressed("D"))
			{
				this.parent.addBlob(x + (width / 2), y - 13); 
			}
			
			if (FlxG.keys.justReleased("UP") && _jump == 1)
			{
				this.velocity.y /= 2;
			}
			
			if (this.isTouching(FLOOR) == true)
			{
				_jump = 0;
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
				
				parent.emit(x + (width / 2), y + height, 0, 5);
			}
			
			super.update();
		}
	
	}

}