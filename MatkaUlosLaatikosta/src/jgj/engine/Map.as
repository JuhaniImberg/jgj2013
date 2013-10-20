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
			add(foreground_map);
			
			em = new EntityManager();
			add(em);
			
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
		
		}
		
		public function Map(i:int)
		{
			TILES = map_tiles;
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
		}
		
		override public function create():void
		{
			loadMapFromJson(new json_1());
			
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
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}