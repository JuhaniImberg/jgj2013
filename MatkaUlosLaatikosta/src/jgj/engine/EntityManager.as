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
			pl = new Player(x, y, id);
			add(pl);
		}
		
		public function getPlayer():Player
		{
			return pl;
		}
		
		public function addBox(x:int, y:int):void
		{
			add(new Box(x, y));
		}
		
		public function addBlob(x:int, y:int):void
		{
			add(new Blob(x, y, pl));
		}
		
		override public function update():void
		{
			FlxG.collide(this, this);
			super.update();
		}
	}
}