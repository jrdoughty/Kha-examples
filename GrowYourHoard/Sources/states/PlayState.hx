package states;

import kha2d.Sprite;
import kha2d.Scene;
import kha.Assets;
import util.Text;
import haxe.Timer;
import Reg;
import actors.Goblin;
import kha2d.Animation;
import actors.Projectile;
import verlet.collision.Colliders;
import kha.math.Vector2;
import actors.Player;

class PlayState extends BaseState
{	
	private var castle:Sprite;
	private var shieldSprite:Sprite;
	private var ogreSprite:Sprite;
	private var greedySprite:Sprite;

	private var shieldCountText:Text;
	private var greedCountText:Text;
	private var ogreCountText:Text;
	private var scoreText:Text;

	private var spawnTimer:Timer;
	private var shootTimer:Timer;
	private var levelTimer:Timer;
	private var soldierTimer:Timer;

	private var player:Player;
	private var floorY:Float = 206;
	private var arrowSpawnX:Float = 250;
	private var arrowSpawnY:Float = 75;
	public var goblins:Array<Goblin> = [];
	private var projectiles:Array<Projectile> = [];

	private var levelTimerFinished = false;

	public function new()
	{
	}
	
	public override function init()
	{
		Reg.inLevel = true;

		Scene.the.addOther(new Sprite(Assets.images.background));
		
		castle = new Sprite(Assets.images.castle);
		castle.x = 250; 
		castle.y = 57;
		Scene.the.addOther(castle);
		createCounts();

		if(Reg.upgrades["large_shield"]["number"] > 0)
		{
			player = new Player(Assets.images.shieldbigger,30,25,0,185);
		}
		else
		{
			player = new Player(Assets.images.shield,20,25,0,185);
		}
		Scene.the.addHero(player);

		spawnTimer = new Timer(getSpawnTime());
		spawnTimer.run = spawn;

		spawn();

		shootTimer = new Timer(getSpawnTime());
		shootTimer.run = shoot;

		Reg.level += 1;
		levelTimer = new Timer((30 + Reg.level) * 1000);
		levelTimer.run = endLevel;

		if (Reg.level > 3)
		{
			soldierTimer = new Timer(Math.round(Math.random() * 15000 + 5000));
			soldierTimer.run = spawnSoldier;
		}
	}

	private function getSpawnTime():Int
	{
		return Math.floor(1000 * Math.random() * 3);
	}

	private function createCounts()
	{
		shieldSprite = new Sprite(Assets.images.shieldui);
		Scene.the.addOther(shieldSprite);
		shieldCountText = new Text(Reg.upgrades["large_shield"]["number"]+"", 0, 25, 16);

		greedySprite = new Sprite(Assets.images.goblinbigbag, 20, 20);
		greedySprite.x = 25;
		Scene.the.addOther(greedySprite);
		greedCountText = new Text(Reg.upgrades["greedy_goblin"]["number"]+"", 28, 25, 16);

		ogreSprite = new Sprite(Assets.images.ogre, 32, 64);
		ogreSprite.scaleX = .35;
		ogreSprite.scaleY = .35;
		ogreSprite.x = 60;
		Scene.the.addOther(ogreSprite);
		ogreCountText = new Text(Reg.upgrades["ogre"]["number"]+"", 58, 25, 16);

		scoreText = new Text(Reg.score+"",128,0,20);
	}


	private function spawn()
	{
		spawnTimer.stop();
		if(!levelTimerFinished)
		{
			spawnTimer = new Timer(getSpawnTime());
			spawnTimer.run = spawn;
		}
		var g:Goblin;

		if (Reg.upgrades["greedy_goblin"]["number"] > 0 && Math.random() > 0.8)
		{
			g = new Goblin(Assets.images.goblinbigbag, 20, 20, 260, 190, 1, 3, -.3, "greedy_goblin",null,new Animation([3,4,5,4], 5));
		}
		else if (Reg.upgrades["ogre"]["number"] > 0 && Math.random() > 0.8)
		{
			g = new Goblin(Assets.images.ogre, 32, 64, 260, 148, 5, 1, -.3, "ogre");
		}
		else
		{
			g = new Goblin(Assets.images.goblin1, 20, 20, 260, 190, 1, 1);
		}
		g.x = 260;
		goblins.push(g);
		Scene.the.addHero(g);
	}
	private function spawnSoldier()
	{
		trace('soldier spawned');
	}
	private function shoot()
	{
		shootTimer.stop();
		shootTimer = new Timer(getSpawnTime());
		shootTimer.run = shoot;
		if (Math.random() > .1 + Reg.level/30)
		{
			trace('arrow');
			projectiles.push(new Projectile(Assets.images.arrow, 8, 8, arrowSpawnX, arrowSpawnY, new Animation([0],0)));
			Scene.the.addProjectile(projectiles[projectiles.length - 1]);
		}
		else
		{
			trace('axe');
			projectiles.push(new Projectile(Assets.images.axe, 8, 8, arrowSpawnX, arrowSpawnY, new Animation([1],0), null, null, 3));
			Scene.the.addProjectile(projectiles[projectiles.length - 1]);
		}
	}


	public override function update()
	{
		var pointX;
		var pointY;
		for(i in goblins)
		{	
			if (!i.alive)
			{
				goblins.remove(i);
			}
		}

		var pToRemove = [];
		var gToRemove = [];
		for(i in projectiles)
		{
			pointX = i.point.composite.particles[0].pos.x;
			pointY = i.point.composite.particles[0].pos.y;
			if (pointX >= player.x && pointX <= player.x + Math.abs(player.width) &&
							pointY >= player.y && pointY <= player.y + player.height )
			{
				if(i.point != null)
				{
					i.point.destroy();
					i.point = null;
				}
				//Scene.the.removeProjectile(i);
				player.spriteCache.addSprite(i);
				pToRemove.push(i);
			}
		}

		for(i in pToRemove)
		{
			projectiles.remove(i);
		}

		for(i in projectiles)
		{
			for(j in goblins)
			{
				pointX = i.point.composite.particles[0].pos.x;
				pointY = i.point.composite.particles[0].pos.y;

				if(j.width < 0 && pointX <= j.x && pointX >= j.x + j.width &&
				pointY >= j.y && pointY <= j.y + j.height )
				{
					trace('killing');
					j.damage(i.dmg);
					if(!j.alive)
					{
						Scene.the.removeHero(j);
						gToRemove.push(j);
					}
					i.kill();
					Scene.the.removeProjectile(i);
					pToRemove.push(i);
					break;
				}
			}
			if(pToRemove.indexOf(i) == -1)
			{
				if(i.y >= floorY)
				{
					if(i.point != null)
					{
						i.point.destroy();
						i.point = null;
					}
					i.setAnimation(i.deadAnim);
					pToRemove.push(i);
				}
			}
		}

		for(i in pToRemove)
		{
			projectiles.remove(i);
		}
		for(i in gToRemove)
		{
			goblins.remove(i);
		}

		shieldCountText.content = Reg.upgrades["large_shield"]["number"]+"";

		greedCountText.content = Reg.upgrades["greedy_goblin"]["number"]+"";

		ogreCountText.content = Reg.upgrades["ogre"]["number"]+"";

		scoreText.content = Reg.score+"";
	}

	public override function kill()
	{
		Reg.inLevel = false;
		super.kill();
		for(i in projectiles)
		{
			i.kill();
		}
		goblins = [];
		projectiles = [];
		castle = null;
		shieldSprite = null;
		ogreSprite = null;
		greedySprite = null;
		spawnTimer.stop();
		shootTimer.stop();
		levelTimer.stop();
	}

	public function endLevel()
	{
		levelTimerFinished = true;
		if(goblins.length == 0)
		{
			//levelTimer.stop();			
			if(Reg.score > 99)
			{
				Project.the.changeState(new WinState());
			}
			else
			{
				Project.the.changeState(new ShowHoardState());
			}
		}
		else
		{
			levelTimer.stop();
			levelTimer = new Timer(1000);
			levelTimer.run = endLevel;
		}
	}
}