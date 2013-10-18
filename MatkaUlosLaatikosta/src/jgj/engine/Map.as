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
		
		public function init(map_tiles:Class, tileset:Class,  tile_w:Number, tile_h:Number) {
			map_tiles = map_tiles;
			TILES = tileset;
			TILE_WIDTH = tile_w;
			TILE_HEIGHT = tile_h;
			
			collisionMap = new FlxTilemap();
			loadMap(map_tiles);
			add(collisionMap);
		}
		
		public function loadMap(map_tiles:Class)
		{			
			collisionMap.loadMap(new map_tiles(), TILES, TILE_WIDTH, TILE_HEIGHT, FlxTilemap.AUTO);
		}
	
	}

}