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
		
		public function emit(x:int, y:int, type:int):void
		{
			var emitter:FlxEmitter = new FlxEmitter(x, y);
			emitter.lifespan = 0.2;
			
			switch(type) {
				case 0:
					for (var i:int = 0; i < 5; i++)
					{
						var particle:FlxParticle = new FlxParticle();
						particle.makeGraphic(2, 2, 0xff00ff00);
						particle.exists = false;
						particle.solid = false;
						particle.maxVelocity.x = 10;
						particle.maxVelocity.y = 10;
						emitter.add(particle);
					}
					break;
				default:
					break;
			}
			
			add(emitter);
			//emitter.start(false);
			emitter.emitParticle();
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