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
		[Embed(source="../../../assets/test_map.txt",mimeType='application/octet-stream')]
		private static var test_map_data:Class;
		
		private var collisionMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var map_tiles:Class;
		
		private var pl:Player;
		private var boxman:BoxManager;
		
		public function loadMap(map_tiles:Class):void
		{
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
		}
		
		public function Map()
		{
			map_tiles = test_map_data;
			TILES = test_map_tiles;
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
		}
		
		override public function create():void
		{
			collisionMap = new FlxTilemap();
			loadMap(map_tiles);
			add(collisionMap);
			pl = new Player(0, 0, 0);
			add(pl);
			
			boxman = new BoxManager(pl);
			add(boxman);
			
			boxman.addBox(32, 32 * 12);
			boxman.addBox(64, 32 * 13);
			
			var cam:FlxCamera = new FlxCamera(0, 0, 640, FlxG.height);
			cam.follow(pl);
			cam.setBounds(0, 0, collisionMap.width, collisionMap.height);
			FlxG.addCamera(cam);
		}
		
		override public function update():void
		{
			
			FlxG.collide(pl, collisionMap);
			FlxG.collide(boxman, collisionMap);
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}