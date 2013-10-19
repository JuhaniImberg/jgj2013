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
		private static var test_map_tiles:Class;
		[Embed(source="../../../assets/tileset0_decor.png")]
		private static var test_map_tiles_decor:Class;
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var test_map_data:Class;
		[Embed(source="../../../assets/test_map_decor.txt",mimeType='application/octet-stream')]
		private static var test_map_data_decor:Class;
		
		private var collisionMap:FlxTilemap;
		private var decorMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var TILES_DECOR:Class;
		private var map_tiles:Class;
		private var map_tiles_decor:Class;
		
		private var pl:Player;
		private var boxman:BoxManager;
		private var bl:Blob;
		
		public function loadMap(map_tiles:Class, map_tiles_decor:Class):void
		{
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
			decorMap.loadMap(new map_tiles_decor(), TILES_DECOR, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
		}
		
		public function Map()
		{
			map_tiles = test_map_data;
			map_tiles_decor = test_map_data_decor;
			TILES = test_map_tiles;
			TILES_DECOR = test_map_tiles_decor;
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
		}
		
		override public function create():void
		{
			collisionMap = new FlxTilemap();
			decorMap = new FlxTilemap();
			
			loadMap(map_tiles, map_tiles_decor);
			add(collisionMap);
			add(decorMap);
			pl = new Player(0, 0, 2);
			add(pl);
			
			boxman = new BoxManager(pl);
			add(boxman);
			
			bl = new Blob(32 * 4, 32 * 13, pl);
			add(bl);
			
			boxman.addBox(32, 32 * 12);
			boxman.addBox(64, 32 * 13);
			
			var cam:FlxCamera = new FlxCamera(0, 0, 640, FlxG.height);
			cam.follow(pl);
			cam.setBounds(0, 0, collisionMap.width, collisionMap.height);
			cam.bgColor = 0xffAFEEEE;
			FlxG.addCamera(cam);
		}
		
		override public function update():void
		{
			
			FlxG.collide(pl, collisionMap);
			FlxG.collide(boxman, collisionMap);
			FlxG.collide(bl, collisionMap);
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}