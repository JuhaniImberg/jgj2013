package jgj.engine
{
	import org.flixel.*;
	
	public class Trigger
	{
		public var id:uint;
		public var type:String;
		public var enabled:Boolean;
		public var fire_once:Boolean;
		public var action:String;
		public var action_num:Number;
		public var action_string:String;
		
		private var em:EntityManager;
		
		public function Trigger(ema:EntityManager, i:uint, t:String, e:Boolean, f:Boolean):void
		{
			id = i;
			type = t;
			enabled = e;
			fire_once = f;
			em = ema;
		}
		
		public function setAction(a:String, a_n:Number, a_s:String):void
		{
			action = a;
			action_num = a_n;
			action_string = a_s;
		}
		
		public function run(x:Number, y:Number, caller:FlxBasic):void
		{
			if (!enabled)
			{
				return;
			}
			
			switch (action)
			{
				case "message":
					em.getPlayer().addText(action_string, action_num);
					break;
				case "spawn":
					switch (action_string)
					{
						case "blob":
							em.addBlob(x, y);
							break;
						default:
							break;
					}
					break;
				case "map":
					FlxG.switchState(new Map(action_num));
				default: 
					break;
			}
			
			if (fire_once)
			{
				enabled = false;
			}
			
		}
	
	}
}