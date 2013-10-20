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
		
		[Embed(source="../../../assets/aikuinentausta.png")]
		private static var bg_2:Class;
		
		[Embed(source="../../../assets/map_1.json",mimeType='application/octet-stream')]
		private static var json_1:Class;
		[Embed(source="../../../assets/map_2.json",mimeType='application/octet-stream')]
		private static var json_2:Class;
		[Embed(source="../../../assets/map_3.json",mimeType='application/octet-stream')]
		private static var json_3:Class;
		[Embed(source="../../../assets/map_4.json",mimeType='application/octet-stream')]
		private static var json_4:Class;
		
		[Embed(source = "../../../assets/taso1.mp3")]
		private static var bgm_1:Class;
		[Embed(source = "../../../assets/taso2.mp3")]
		private static var bgm_2:Class;
		[Embed(source = "../../../assets/taso3.mp3")]
		private static var bgm_3:Class;
		[Embed(source = "../../../assets/taso4.mp3")]
		private static var bgm_4:Class;
		
		private static var json_map:Class;
		
		private var collisionMap:FlxTilemap;
		private var decorMap:FlxTilemap;
		
		private var TILE_WIDTH:Number;
		private var TILE_HEIGHT:Number;
		private var TILES:Class;
		private var cam:FlxCamera;
		private var bg:FlxSprite;
		
		private var em:EntityManager;
		public var background_map:FlxTilemap;
		public var collision_map:FlxTilemap;
		public var foreground_map:FlxTilemap;
		public var trigger_map:FlxTilemap;
		private var triggers:Array;
		public var id:uint;
		
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
			
			trigger_map.visible = false;
			
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
				
				if (tmp2.action.x != undefined)
				{
					trace("a");
					tmp3.x = tmp2.action.x;
					tmp3.y = tmp2.action.y;
				}
				
				triggers.push(tmp3);
			}
		
		}
		
		public function Map(i:int)
		{
			TILES = map_tiles;
			TILE_WIDTH = 32;
			TILE_HEIGHT = 32;
			id = i;
			switch (i)
			{
				case 0: 
					json_map = json_1;
					FlxG.playMusic(bgm_1, 0.5);
					break;
				case 1: 
					json_map = json_2;
					FlxG.playMusic(bgm_2, 0.5);
					break;
				case 2: 
					json_map = json_3;
					FlxG.playMusic(bgm_3, 0.5);
					break;
				case 3: 
					json_map = json_4;
					FlxG.playMusic(bgm_4, 0.5);
					break;
				default: 
					json_map = json_1;
					break;
			}
		}
		
		override public function create():void
		{
			/* kivi */
			
			bg = new FlxSprite(0, 0);
			bg.loadGraphic(bg_2);
			add(bg);
			/* end kivi */
			
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
										triggers[j].run(em.members[i].x, em.members[i].y, em.members[i], this);
									break;
								case "blob": 
									if (em.members[i] as Blob != null)
										triggers[j].run(em.members[i].x, em.members[i].y, em.members[i], this);
									break;
								case "box": 
									if (em.members[i] as Blob != null)
										triggers[j].run(em.members[i].x, em.members[i].y, em.members[i], this);
									break;
								default: 
									break;
							}
						}
					}
				}
			}
			
			bg.x = cam.scroll.x - cam.scroll.x / 3;
			bg.y = cam.scroll.y - cam.scroll.y / 3;
			
			if (FlxG.keys.justPressed("R"))
			{
				FlxG.switchState(new Map(id));
			}
			
			super.update();
		}
		
		public override function draw():void
		{
			super.draw();
		}
	
	}

}