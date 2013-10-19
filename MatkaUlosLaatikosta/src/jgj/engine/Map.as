package jgj.engine
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author kivibot
	 */
	public class Map extends FlxState
	{
		
		private var collisionMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var map_tiles:Class;
		
		private var pl:Player;
		
		public function loadMap(map_tiles:Class):void
		{
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.OFF);
		}
		
		public function Map(a:Class, tileset:Class, tile_w:Number, tile_h:Number)
		{
			map_tiles = a;
			TILES = tileset;
			TILE_WIDTH = tile_w;
			TILE_HEIGHT = tile_h;
			
			trace("asd");
		}
		
		override public function create():void
		{
			collisionMap = new FlxTilemap();
			loadMap(map_tiles);
			add(collisionMap);
			pl = new Player(0, 0, 0);
			add(pl);
			
			var cam:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height); 
			cam.follow(pl);
			cam.setBounds(0, 0, collisionMap.width, collisionMap.height);
			cam.color = 0xFFCCCC;
			FlxG.addCamera(cam);
		}
		
		override public function update():void
		{
			
			FlxG.collide(pl, collisionMap);
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
			//highlightBox.drawDebug();
		}
	
	}

}