package jgj.engine
{
	
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Player extends FlxSprite
	{
		
		[Embed(source="../../../assets/taapero.png")]
		private var player_sprite_0:Class;
		
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
			acceleration.y = 420;
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			
			//animations
			addAnimation("idle", [0]);
			addAnimation("run", [0, 1], 6);
			addAnimation("jump", [4]);
		
		}
		
		override public function update():void
		{
			this.acceleration.x = 0;
			if (FlxG.keys.LEFT)
			{
				this.facing = FlxObject.LEFT;
				this.acceleration.x = -this.drag.x;
			}
			if (FlxG.keys.RIGHT)
			{
				this.facing = FlxObject.RIGHT;
				this.acceleration.x = this.drag.x;
			}
			if (FlxG.keys.UP && this.velocity.y == 0)
			{
				this.velocity.y = -200;
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