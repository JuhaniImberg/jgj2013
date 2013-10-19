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
		[Embed(source="../../../assets/aikuinen.png")]
		private var player_sprite_1:Class;
		[Embed(source="../../../assets/vanhua.png")]
		private var player_sprite_2:Class;
		private var _jump:Number;
		
		public function Player(x:Number, y:Number, plid:Number)
		{
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
					addAnimation("run", [0, 1], 6);
					w = 22;
					h = 44;
					break;
				case 1: 
					img = player_sprite_1;
					addAnimation("run", [0, 1, 2, 3], 6);
					w = 25;
					h = 50;
					break;
				case 2: 
					img = player_sprite_2;
					addAnimation("run", [0, 1], 6);
					maxVelocity.y = 90;
					w = 19;
					h = 35;
					break;
				default: 
					break;
			}
			loadGraphic(img, true, true, w, h);
			
			
			
			//animations
			addAnimation("idle", [0]);
			addAnimation("jump", [0]);
		
		}
		
		override public function update():void
		{
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
			}
			
			super.update();
		}
	
	}

}