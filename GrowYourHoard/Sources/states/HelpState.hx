package states;

import util.Text;
import kha2d.Sprite;
import util.Button;
import kha.Assets;
import kha2d.Scene;

/**
 * A FlxState which can be used for the game's menu.
 */
class HelpState extends BaseState
{
	var playBtn:Button;
	var menuBtn:Button;

	public function new()
	{

	}

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function init():Void
	{
		super.init();
		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		new Text("Help",120,0, 40);
		new Text("Press A Left or Click to", 0, 50, 16);
		new Text("go Left and Press D Right", 0, 70, 16);
		new Text("or Right Click to go Right", 0, 90, 16); 
		new Text("and shield your loyal", 0, 110, 16);
		new Text("minions from arrow fire", 0, 130, 16);
		new Text("Double Tap to perform a dash", 0, 150, 16);
		new Text("attack that\n\n fends off soldiers", 0, 170, 16);
		new Button(25, 200, 120, 30, new Sprite(Assets.images.button), "PLAY", play);
		new Button(160, 200, 120, 30, new Sprite(Assets.images.button), "MENU", menu);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function kill():Void
	{
		super.kill();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}

	public function play(?b:Int,?x:Int,?y:Int)
	{
		Reg.reset();
		Project.the.changeState(new PlayState());
	}

	public function menu(?b:Int,?x:Int,?y:Int)
	{
		Project.the.changeState(new MenuState());
	}
}