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
import sdg.graphics.tiles.Tileset;
import sdg.graphics.tiles.Tilemap;
import sdg.Object;
import sdg.atlas.Region;
import sdg.graphics.TileSprite;

class PlayScreen extends Screen
{
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
							var ts = new TileSprite(Assets.images.floors,32,32);
							ts.set_region(sdg.atlas.Atlas.createRegion(Assets.images.floors,(tile.gid-1)*32,0,32,32));
							add(new Object((i%layer.width) * 32, Std.int(i/layer.width)*32 , ts));
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
				default:
			}

		}

		//add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));
		//add(new Player(0,0,Assets.images.knight,32,32));
		//kha.Scheduler.addTimeTask(function(){add(new Enemy(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
//		kha.Scheduler.addTimeTask(function(){add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
	}
}