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

class PlayState implements IState
{	
	private var background:Sprite;
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
	private var circ:Circle;
	private var circX:Float = 270+ 1000;
	private var circY:Float = 100;
	private var circMX:Float = 9;
	private var circMY:Float = 5;
	private var floorY:Float = 206;
	private var arrowSpawnX:Float = 250;
	private var arrowSpawnY:Float = 75;
	public var goblins:Array<Goblin> = [];
	private var projectiles:Array<Projectile> = [];
	private var fCount:Int = 0;

	public function new()
	{
	}
	
	public function init()
	{
		background = new Sprite(Assets.images.background);
		background.x = 0;
		background.y = 0;
		Scene.the.addOther(background);
		
		castle = new Sprite(Assets.images.castle);
		castle.x = 250; 
		castle.y = 57;
		Scene.the.addOther(castle);
		createCounts();

		spawnTimer = new Timer(getSpawnTime());
		spawnTimer.run = spawn;

		spawn();

		shootTimer = new Timer(getSpawnTime());
		shootTimer.run = shoot;

		Reg.level += 1;
		levelTimer = new Timer((30 + Reg.level) * 1000);
		levelTimer.run = kill;

		if (Reg.level > 3)
		{
			soldierTimer = new Timer(Math.round(Math.random() * 15000 + 5000));
			soldierTimer.run = spawnSoldier;
		}
	}

	private function getSpawnTime():Int
	{
		return Math.floor(1000 * Math.random() * 4);
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
		spawnTimer = new Timer(getSpawnTime());
		spawnTimer.run = spawn;

		var g:Goblin;

		if (Reg.upgrades["greedy_goblin"]["number"] > 0 && Math.random() > 0.8)
		{
			g = new Goblin(Assets.images.goblinbigbag, 20, 20, 260, 190, 1, 3, .3, "greedy_goblin",null,new Animation([3,4,5,4], 5));
			trace('greed');
		}
		else if (Reg.upgrades["ogre"]["number"] > 0 && Math.random() > 0.8)
		{
			g = new Goblin(Assets.images.ogre, 32, 64, 260, 148, 5, 1);
			trace('ogre');
		}
		else
		{
			g = new Goblin(Assets.images.goblin1, 20, 20, 260, 190, 1, 1);
			g.y = 190;
		}
		g.scaleX = -1;
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
			projectiles.push(new Projectile(Assets.images.axe, 8, 8, arrowSpawnX, arrowSpawnY, new Animation([1],0)));
			Scene.the.addProjectile(projectiles[projectiles.length - 1]);
		}
	}


	public function update()
	{
		for(i in goblins)
		{
			
			if (i.x < 0 - i.width)
			{
				Reg.score += i.getScore();
				i.kill();
				goblins.splice(goblins.indexOf(i), 1)[0] = null;//kill the goblins with fire!
			}
		}

		for(i in projectiles)
		{
			if(i.y >= floorY)
			{
				i.point = null;
				
				i.setAnimation(i.deadAnim);
			}
		}

		shieldCountText.content = Reg.upgrades["large_shield"]["number"]+"";

		greedCountText.content = Reg.upgrades["greedy_goblin"]["number"]+"";

		ogreCountText.content = Reg.upgrades["ogre"]["number"]+"";

		scoreText.content = Reg.score+"";
	}

	public function kill()
	{
		/*
		for(i in goblins)
		{
			Scene.the.removeOther(i);
			i = null;
		}
		Scene.the.removeOther(background);
		Scene.the.removeOther(castle);
		Scene.the.removeOther(shieldSprite);
		Scene.the.removeOther(ogreSprite);
		Scene.the.removeOther(greedySprite);
		*/
		Scene.the.clear();
		goblins = [];
		background = null;
		castle = null;
		shieldSprite = null;
		ogreSprite = null;
		greedySprite = null;
		spawnTimer.stop();
		shootTimer.stop();
		levelTimer.stop();
		Text.clear();
	}
}