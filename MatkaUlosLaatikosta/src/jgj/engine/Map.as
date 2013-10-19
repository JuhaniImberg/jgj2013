package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot & Juhani Imberg
	 */
	public class Map extends FlxState
	{
		
		[Embed(source="../../../assets/tileset0.png")]
		private static var map_tiles:Class;
		[Embed(source="../../../assets/tileset0_decor.png")]
		private static var map_tiles_decor:Class;
		[Embed(source="../../../assets/tileset0_decor.png")]
		private static var map_tiles_trigger:Class;
		
		
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var map_1_data:Class;
		[Embed(source="../../../assets/test_map_decor.txt",mimeType='application/octet-stream')]
		private static var map_1_data_decor:Class;
		
		[Embed(source = "../../../assets/map_1.json", mimeType = 'application/octet-stream')]
		private static var json_1:Class;
		
		private var collisionMap:FlxTilemap;
		private var decorMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var TILES_DECOR:Class;
		private var TILES_TRIGGER:Class;
		private var map_tiles:Class;
		private var map_tiles_decor:Class;
		private var cam:FlxCamera;
		
		private var em:EntityManager;
		private var background_map:FlxTilemap;
		private var collision_map:FlxTilemap;
		private var foreground_map:FlxTilemap;
		private var trigger_map:FlxTilemap;
		
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
			
			background_map.loadMap	(FlxTilemap.arrayToCSV(tmp.layers[0], width), TILES_DECOR, 	TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			collision_map.loadMap	(FlxTilemap.arrayToCSV(tmp.layers[1], width), TILES, 		TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			foreground_map.loadMap	(FlxTilemap.arrayToCSV(tmp.layers[2], width), TILES_DECOR, 	TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			trigger_map.loadMap		(FlxTilemap.arrayToCSV(tmp.layers[3], width), TILES_TRIGGER, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			
			add(background_map);
			add(collision_map);
			add(foreground_map);
			
			em = new EntityManager();
			add(em);
			
			for (var i:int = 0; i < tmp.entities.length; i++ )
			{
				var tmp2:Object = tmp.entities[i];
				switch (tmp2.type)
				{
					case "player":
						em.addPlayer(tmp2.x, tmp2.y, tmp2.number);
						break;
					case "blob":
						em.addBlob(tmp2.x, tmp2.y);
					case "box":
						em.addBox(tmp2.x, tmp2.y);
					default:
						break;
				}
			}
			
			
			
			
			
		}
		
		public function loadMap(map_tiles:Class, map_tiles_decor:Class):void
		{
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			decorMap.loadMap(new map_tiles_decor(), TILES_DECOR, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
		}
		
		public function Map(i:int)
		{
			TILES = map_tiles;
			TILES_DECOR = map_tiles_decor;
			TILES_TRIGGER = map_tiles_trigger;
			
			/*switch (i)
			{
				case 0:
					map_tiles = map_1_data;
					map_tiles_decor = map_1_data_decor;
					TILES = map_1_tiles;
					TILES_DECOR = map_1_tiles_decor;
					
			}*/
			
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
		}
		
		override public function create():void
		{
			loadMapFromJson(new json_1());
			/*
			collisionMap = new FlxTilemap();
			decorMap = new FlxTilemap();
			
			loadMap(map_tiles, map_tiles_decor);
			add(collisionMap);
			add(decorMap);
			
			em = new EntityManager();
			add(em);
			em.addPlayer(32 * 8, 32 * 28, 0);
			em.addBox(32, 32 * 12);
			em.addBox(64, 32 * 13);
			em.addBlob(32 * 7, 32 * 28);
			*/
			cam = new FlxCamera(0, 0, 640, 480);
			cam.follow(em.getPlayer(), FlxCamera.STYLE_PLATFORMER);
			cam.setBounds(0, 0, collisionMap.width, collisionMap.height, true);
			
			cam.bgColor = 0xffAFEEEE;
			FlxG.addCamera(cam);
			
			

		}
		
		override public function update():void
		{
			em.asupdate();
			FlxG.collide(em, collision_map);
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}