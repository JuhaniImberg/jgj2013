package jgj.engine
{
	import org.flixel.*;
	
	class BoxManager extends FlxGroup
	{
		private var pl:Player;
		
		public function BoxManager(p:Player):void
		{
			super();
			pl = p;
		}
		
		public function addBox(x:int, y:int):void
		{
			add(new Box(x, y));
		}
		
		override public function update():void
		{
			FlxG.collide(pl, this);
			super.update();
		}
	}
}