package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Map extends FlxState
	{
		
		[Embed(source="../../../assets/tile.png")]
		private static var map_tiles:Class;
		
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var map_1_data:Class;
		[Embed(source="../../../assets/test_map_decor.txt",mimeType='application/octet-stream')]
		private static var map_1_data_decor:Class;
		
		[Embed(source="../../../assets/map_1.json",mimeType='application/octet-stream')]
		private static var json_1:Class;
		[Embed(source="../../../assets/map_2.json",mimeType='application/octet-stream')]
		private static var json_2:Class;
		
		private static var json_map:Class;
		
		private var collisionMap:FlxTilemap;
		private var decorMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var cam:FlxCamera;
		
		private var em:EntityManager;
		private var background_map:FlxTilemap;
		private var collision_map:FlxTilemap;
		private var foreground_map:FlxTilemap;
		private var trigger_map:FlxTilemap;
		private var triggers:Array;
		
		public function loadMapFromJson(data:String):void
		{
			
			var tmp:Object = JSON.parse(data);
			var width:uint = tmp.width;
			var height:uint = tmp.height;
			var name:String = tmp.name;
			
			background_map = new FlxTilemap();
			collision_map = new FlxTilemap();
			foreground_map = new FlxTilemap();
			trigger_map = new FlxTilemap();
			
			background_map.loadMap(FlxTilemap.arrayToCSV(tmp.layers[0], width), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			collision_map.loadMap(FlxTilemap.arrayToCSV(tmp.layers[1], width), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			foreground_map.loadMap(FlxTilemap.arrayToCSV(tmp.layers[2], width), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			trigger_map.loadMap(FlxTilemap.arrayToCSV(tmp.layers[3], width), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			
			add(background_map);
			add(collision_map);
			add(trigger_map);
			
			trigger_map.visible = visible;
			
			em = new EntityManager();
			add(em);
			
			add(foreground_map);
			
			for (var i:int = 0; i < tmp.entities.length; i++)
			{
				var tmp2:Object = tmp.entities[i];
				switch (tmp2.type)
				{
					case "player": 
						em.addPlayer(tmp2.x * TILE_WIDTH, tmp2.y * TILE_HEIGHT, tmp2.number);
						break;
					case "blob": 
						em.addBlob(tmp2.x * TILE_WIDTH, tmp2.y * TILE_HEIGHT);
						break;
					case "box": 
						em.addBox(tmp2.x * TILE_WIDTH, tmp2.y * TILE_HEIGHT);
						break;
					default: 
						break;
				}
			}
			
			triggers = new Array();
			
			for (var i:int = 0; i < tmp.triggers.length; i++)
			{
				var tmp2:Object = tmp.triggers[i];
				var tmp3:Trigger = new Trigger(em, tmp2.id, tmp2.type, tmp2.enabled, tmp2.fire_once);
				tmp3.setAction(tmp2.action.type, tmp2.action.num, tmp2.action.string);
				triggers.push(tmp3);
			}
		
		}
		
		public function Map(i:int)
		{
			TILES = map_tiles;
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
			switch (i)
			{
				case 0:
					json_map = json_1;
					break;
				case 1:
					json_map = json_2;
					break;
				default:
					json_map = json_1;
					break;
			}
		}
		
		override public function create():void
		{
			loadMapFromJson(new json_map());
			
			cam = new FlxCamera(0, 0, 640, 480);
			cam.follow(em.getPlayer(), FlxCamera.STYLE_PLATFORMER);
			cam.setBounds(0, 0, collision_map.width, collision_map.height, true);
			cam.bgColor = 0xffAFEEEE;
			FlxG.addCamera(cam);
		
		}
		
		override public function update():void
		{
			em.asupdate();
			FlxG.collide(em, collision_map);
			
			for (var i:int = 0; i < em.members.length; i++)
				{
					if (trigger_map.overlaps(em.members[i]))
					{
						var xxx:int = em.members[i].x / TILE_WIDTH;
						var yyy:int = em.members[i].y / TILE_HEIGHT;
						var zzz:uint = trigger_map.getTile(xxx, yyy);
						for (var j:int = 0; j < triggers.length; j++)
						{
							if (triggers[j].id == zzz)
							{
								switch (triggers[j].type)
								{
									case "player":
										if (em.members[i] as Player != null)
											triggers[j].run(em.members[i].x, em.members[i].y, em.members[i]);
										break;
									case "blob":
										if (em.members[i] as Blob != null)
											triggers[j].run(em.members[i].x, em.members[i].y, em.members[i]);
										break;
									case "box":
										if (em.members[i] as Blob != null)
											triggers[j].run(em.members[i].x, em.members[i].y, em.members[i]);
										break;
									default:
										break;
								}
							}
						}
					}
				}
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}