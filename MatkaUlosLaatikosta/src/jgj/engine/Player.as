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
		[Embed(source="../../../assets/teini.png")]
		private var player_sprite_1:Class;
		[Embed(source="../../../assets/aikuinen.png")]
		private var player_sprite_2:Class;
		[Embed(source="../../../assets/vanhua.png")]
		private var player_sprite_3:Class;
		
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
			var w:Number, h:Number;
			
			//bounding box tweaks
			width = w;
			height = h;
			offset.x = 0;
			offset.y = 0;
			
			//basic player physics
			drag.x = 640;
			acceleration.y = 600;
			maxVelocity.x = 120;
			maxVelocity.y = 300;
			
			switch (plid)
			{
				case 0: 
					img = player_sprite_0;
					addAnimation("run", [1, 2], 6);
					addAnimation("idle", [2]);
					addAnimation("jump", [0]);
					addAnimation("crouch", [0]);
					w = 22;
					h = 44;
					break;
				case 1: 
					img = player_sprite_1;
					addAnimation("run", [0, 2, 3, 4], 6);
					addAnimation("idle", [0]);
					addAnimation("jump", [1]);
					addAnimation("crouch", [1]);
					w = 20;
					h = 49;
					break;
				case 2: 
					img = player_sprite_2;
					addAnimation("run", [1, 2, 3, 4], 6);
					addAnimation("idle", [2]);
					addAnimation("jump", [0]);
					addAnimation("crouch", [0]);
					w = 25;
					h = 50;
					break;
				case 3: 
					img = player_sprite_3;
					addAnimation("run", [0, 1], 6);
					addAnimation("idle", [2]);
					maxVelocity.y = 90;
					w = 19;
					h = 35;
					break;
				default: 
					break;
			}
			loadGraphic(img, true, true, w, h);
			
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
			var skip_anim:Boolean = false;
			
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
			if (FlxG.keys.DOWN && _jump == 0)
			{
				this.play("crouch");
				skip_anim = true;
				offset.y = -5;
				this.acceleration.x = 0;
			}
			else
			{
				offset.y = 0;
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
			
			if (this.isTouching(FLOOR) == true && _jump != 0)
			{
				_jump = 0;
				parent.emit(x + (width / 2), y + (height), 1, 20);
			}
			
			if (!skip_anim)
			{
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
					
					parent.emit(x + (width / 2), y + height, 0, 1);
				}
			}
			super.update();
		}
	
	}

}