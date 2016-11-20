package states;

import kha2d.Sprite;
import kha2d.Scene;
import kha.Assets;
import util.Text;
import haxe.Timer;
import Reg;
import actors.Goblin;

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
		return Math.floor(2000 * (Math.random()));
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
			g = new Goblin(Assets.images.goblinbigbag, 20, 20, 260, 190, 1, 3);
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
		Reg.goblins.push(g);
		Scene.the.addOther(g);
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
		}
		else
		{
			trace('axe');
		}
	}



	public function update()
	{

		for(i in Reg.goblins)
		{
			
			if (i.x < 0 - i.width)
			{
				Reg.score += i.getScore();
				i.kill();
				Reg.goblins.splice(Reg.goblins.indexOf(i), 1);
			}
		}

		shieldCountText.content = Reg.upgrades["large_shield"]["number"]+"";

		greedCountText.content = Reg.upgrades["greedy_goblin"]["number"]+"";

		ogreCountText.content = Reg.upgrades["ogre"]["number"]+"";

		scoreText.content = Reg.score+"";
	}

	public function kill()
	{
		for(i in Reg.goblins)
		{
			Scene.the.removeOther(i);
			i = null;
		}
		Reg.goblins = [];
		Scene.the.removeOther(background);
		Scene.the.removeOther(castle);
		Scene.the.removeOther(shieldSprite);
		Scene.the.removeOther(ogreSprite);
		Scene.the.removeOther(greedySprite);
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