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
		
		public function Player(x:Number, y:Number, plid:Number)
		{
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
			
			// mario jump
			
			if (_jump == 0 && FlxG.keys.UP)
			{
				this.velocity.y = -300;
				_jump = 1;
			}
			
			if (this.isTouching(FLOOR) == true)
			{
				_jump = 0;
			}
			
			// end mariojump
			
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