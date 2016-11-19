package states;

import kha2d.Sprite;
import kha2d.Scene;
import kha.Assets;
import util.Text;
import haxe.Timer;
import Reg;

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

		//spawn();
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

		var s:Sprite;

		if (Reg.upgrades["greedy_goblin"]["number"] > 0 || Math.random() > 0.8)
		{
			s = new Sprite(Assets.images.goblinbigbag,20,20);
			s.y = 190;
			trace('greed');
		}
		else if (Reg.upgrades["ogre"]["number"] > 0 || Math.random() > 0.8)
		{
			s = new Sprite(Assets.images.ogre, 32, 64);
			s.y = 148;
			trace('ogre');
		}
		else
		{
			s = new Sprite(Assets.images.goblin1,20,20);
			s.y = 190;
		}
		s.scaleX = -1;
		s.x = 260;

		Scene.the.addOther(s);
	}

	public function kill()
	{

	}
}