package states;

import util.Text;
import util.Button;
import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;

/**
 * A FlxState which can be used for the game's menu.
 */
class HoardState extends BaseState
{
	private var subHead:Text;
	private var head:Text;
	private var scoreText:Text;
	private var greedCountText:Text;
	private var ogreCountText:Text;
	private var shieldCountText:Text;
	private var menuButtons:Array<Button>;
	private var ogre:Sprite;
	private var greed:Sprite;
	private var shield:Sprite;
	private var coin:Sprite;

	private static var buttons = [
		"NEXT LEVEL" => [
			"x"        => 40,
			"y"        => 200,
			"width"    => 240,
			"height"   => 30,
			"callback" => 0
		],
		"OGRE" => [
			"x"        => 40,
			"y"        => 155,
			"width"    => 240,
			"height"   => 30,
			"callback" => 1
		],
		"GREEDY GOBLIN" => [
			"x"        => 40,
			"y"        => 120,
			"width"    => 240,
			"height"   => 30,
			"callback" => 2
		],
		"LARGE SHIELD" => [
			"x"        => 40,
			"y"        => 85,
			"width"    => 240,
			"height"   => 30,
			"callback" => 3
		]
	];

	public function new()
	{

	}

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	public override function init():Void
	{
		menuButtons = [];

		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		subHead = new Text("GROW YOUR", 20, 0, 20);
		head = new Text("HOARD", 33, 25, 20);
		
		createUnitCounts();
		createButtons();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	public override function kill():Void
	{
		super.kill();
		head = null;
		subHead = null;
		scoreText = null;
		shieldCountText = null;
		greedCountText = null;
		ogreCountText = null;
		menuButtons = [];
		coin = null;
		greed = null;
		shield = null;
		ogre = null;
	}

	/**
	 * Function that is called once every frame.
	 */
	public override function update():Void
	{
		updateUnitCounts();
	}

	private function buy(itemOrUnitName:String)
	{
		if (Reg.score >= Reg.upgrades[itemOrUnitName]["cost"])
		{
			Reg.score -= Reg.upgrades[itemOrUnitName]["cost"];
			Reg.upgrades[itemOrUnitName]["number"] += 1;
		}
	}

	private function play(?b:Int,?x:Int,?y:Int)
	{
		Project.the.changeState(new PlayState());
	}

	private function buyOgre(?b:Int,?x:Int,?y:Int)
	{
		buy("ogre");
	}

	private function buyGreedyGoblin(?b:Int,?x:Int,?y:Int)
	{
		buy("greedy_goblin");
	}

	private function buyShield(?b:Int,?x:Int,?y:Int)
	{
		buy("large_shield");
	}

	private function createButtons()
	{
		var callbacks = [
			play,
			buyOgre,
			buyGreedyGoblin,
			buyShield
		];
		var callbacksWorth = [
			"",
			"1",
			"1",
			"3"
		];

		for (buttonName in buttons.keys())
		{
			var button:Button = new Button(buttons[buttonName]["x"],
										   buttons[buttonName]["y"],
										   buttons[buttonName]["width"],
										   buttons[buttonName]["height"],
										   new Sprite(Assets.images.button),
										   buttonName+" " + callbacksWorth[buttons[buttonName]["callback"]],
										   callbacks[buttons[buttonName]["callback"]]);

			menuButtons.push(button);

		}
	}
	
	private function updateUnitCounts()
	{
		ogreCountText.content = Reg.upgrades["ogre"]["number"]+"";
		greedCountText.content = Reg.upgrades["greedy_goblin"]["number"]+"";
		shieldCountText.content = Reg.upgrades["large_shield"]["number"]+"";
		scoreText.content = Reg.score+"";
	}
	
	private function createUnitCounts()
	{
		scoreText = new Text("0 Gold",176, 25);
		shieldCountText = new Text("", 205,25);
		greedCountText = new Text("", 236,25);
		ogreCountText = new Text("", 268,25);

		coin = new Sprite(Assets.images.coin,8,8);
		coin.scaleX = 2;
		coin.scaleY = 2;
		shield = new Sprite(Assets.images.shieldui);
		greed = new Sprite(Assets.images.goblinbigbag,20, 20);
		ogre = new Sprite(Assets.images.ogre,24, 28);
		coin.x = 180;
		shield.x = 210;
		greed.x = 240;
		ogre.x = 266;
		ogre.y = -6;
		Scene.the.addOther(coin);
		Scene.the.addOther(shield);
		Scene.the.addOther(greed);
		Scene.the.addOther(ogre);
		
	}
}