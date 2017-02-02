package screens;

import sdg.Screen;
import actors.Player;
import actors.Enemy;
import actors.EnemyAI;
import kha.Assets;
import kha.Scheduler;
import format.tmx.Reader;
import format.tmx.Data.TmxMap;
import format.tmx.Data.TmxTileLayer;
import format.tmx.Data.TmxObjectGroup;
import sdg.graphics.tiles.Tileset;
import sdg.graphics.tiles.Tilemap;
import sdg.Object;
import sdg.atlas.Region;
import sdg.graphics.TileSprite;
import collision.Wall;

class PlayScreen extends Screen
{
	var walls:Array<Wall> = [];
	public function new()
	{
		super();

		var r = new Reader(Xml.parse(Assets.blobs.level_tmx.toString()));
		var t:TmxMap = r.read();
		
		var i = -1;
		for(layer in t.layers)
		{
			switch(layer)
			{
				case TileLayer(layer):
					if(layer.name == 'Background')
					{
						//trace(layer);
						i = -1;
						for(tile in layer.data.tiles)	
						{
							i++;
							var ts = new TileSprite(Assets.images.floors,32,32,(tile.gid-1),0);
							//ts.set_region(sdg.atlas.Atlas.createRegion(Assets.images.floors,(tile.gid-1)*32,0,32,32));
							ts.region = sdg.atlas.Atlas.createRegion(Assets.images.floors,(tile.gid-1)*32,0,32,32);
							var o = new Object((i%layer.width) * 32, Std.int(i/layer.width)*32 , ts);
							add(o);
							//o.graphic.setClipping(Std.int(i/layer.width)*32,0,32,32);
						}
					}
					else if (layer.name == 'EnemyLayer')
					{
						i = -1;
						for(tile in layer.data.tiles)
						{
							i++;
							if(tile.gid>0)
							{
								add(new EnemyAI((i%layer.width) * 32, Std.int(i/layer.width)*32,Assets.images.redknight,32,32));
							}
						}
					}
					else if (layer.name == 'PlayerLayer')
					{
						i = -1;
						for(tile in layer.data.tiles)
						{
							i++;
							if(tile.gid>0)
							{
								add(new Player((i%layer.width) * 32, Std.int(i/layer.width)*32,Assets.images.knight,32,32));
							}
						}
					}
				case ObjectGroup(layer):
					if(layer.name == 'Boundries')
					{
						for(i in layer.objects)
						{
							//trace(i.x);
							var x = Std.int(i.x);
							var y = Std.int(i.y);
							var w = Std.int(i.width);
							var h = Std.int(i.height);
							walls.push(new Wall(x, y, w, h));
						}
					}
				default:
					trace(layer);

			}

		}

		//add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));
		//add(new Player(0,0,Assets.images.knight,32,32));
		//kha.Scheduler.addTimeTask(function(){add(new Enemy(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
//		kha.Scheduler.addTimeTask(function(){add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
	}
}