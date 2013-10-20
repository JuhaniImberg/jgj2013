package jgj.engine
{
	import org.flixel.*;
	
	public class EntityManager extends FlxGroup
	{
		
		private var pl:Player;
		
		public function EntityManager():void
		{
			super();
		}
		
		public function addPlayer(x:int, y:int, id:int):void
		{
			pl = new Player(this, x, y, id);
			add(pl);
		}
		
		public function getPlayer():Player
		{
			return pl;
		}
		
		public function addBox(x:int, y:int):void
		{
			add(new Box(this, x, y));
		}
		
		public function addBlob(x:int, y:int):void
		{
			add(new Blob(this, x, y, pl));
		}
		
		public function emit(x:int, y:int, type:int, num:int):void
		{
			var emitter:FlxEmitter = new FlxEmitter(x, y);
			emitter.lifespan = 0.2;
			
			for (var i:int = 0; i < num; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.exists = false;
				particle.solid = false;
				
				switch(type) {
					case 0:
						particle.makeGraphic(4, 4, 0xAAACACAC);
						particle.maxVelocity.x = 10;
						particle.maxVelocity.y = 10;
						break;
					case 1:
						particle.makeGraphic(4, 4, 0xAAACACAC);
						particle.maxVelocity.x = 100;
						particle.maxVelocity.y = 10;
						break;
					default:
						break;
				}
				
				emitter.add(particle);
			}
			add(emitter);
			
			for (var i:int = 0; i < num; i++)
			{
				emitter.emitParticle();
			}
		}
		
		public function asupdate():void
		{
			FlxG.collide(this, this);
		}
		
		override public function update():void
		{
			FlxG.collide(this, this);
			super.update();
		}
	}
}