package states;

import kha2d.Sprite;
import kha2d.Scene;
import kha.Assets;
import util.Text;
import Reg;

class PlayState implements IState
{	
	private var background:Sprite;
	private var castle:Sprite;
	private var shieldSprite:Sprite;
	private var goblinSprite:Sprite;
	private var greedySprite:Sprite;
	private var shieldCountText:Text;
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
		createUnitCounts();
	}

	private function createUnitCounts()
	{
		shieldSprite = new Sprite(Assets.images.shieldui);
		Scene.the.addOther(shieldSprite);
		shieldCountText = new Text(Reg.upgrades["large_shield"]["number"]+"", 0, 32);
		/*
		
		add(new UIUnit(0, 18, new GreedyGoblin()));
		greedCountText = new FlxText(16, 18, 32);
		greedCountText.text = Reg.upgrades["greedy_goblin"]["number"]+"";
		greedCountText.setFormat(AssetPaths.Our_Arcade_Games__ttf, 12, FlxColor.GOLDEN, "left");
		greedCountText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		add(greedCountText);
		
		add(new UIUnit(4, 36, new Ogre()));
		ogreCountText = new FlxText(16, 36, 32);
		ogreCountText.text = Reg.upgrades["ogre"]["number"]+"";
		ogreCountText.setFormat(AssetPaths.Our_Arcade_Games__ttf, 12, FlxColor.GOLDEN, "left");
		ogreCountText.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		add(ogreCountText);*/
	}

	public function kill()
	{

	}
}