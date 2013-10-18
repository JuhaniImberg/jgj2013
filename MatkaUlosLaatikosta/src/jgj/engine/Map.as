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
		
		public function loadMap(map_tiles:Class)
		{
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
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
			
			trace(TILE_HEIGHT);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
			//highlightBox.drawDebug();
		}
	
	}

}