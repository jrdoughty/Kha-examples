package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import util.Button;

/**
 * A FlxState which can be used for the game's menu.
 */
class HelpState extends FlxState
{
	var text:FlxText;
	var head:FlxText;
	var playBtn:util.Button;
	var menuBtn:util.Button;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		head = new FlxText(0,20, 320);
		head.text = "Help";
		head.setFormat(AssetPaths.Our_Arcade_Games__ttf, 20, FlxColor.GOLDEN, "center");
		head.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		head.scale.set(2, 2);
		text = new FlxText(0, 60, 300);
		text.text = "Press A Left or Clickto go Left and Press D Right\n\n or Right Click to go Right and shield your\n\n loyal minions from arrow fire\n\nDouble Tap to perform a dash attack that\n\n fends off soldiers";
		text.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");

		text.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		playBtn = new util.Button(100, 150, 120, 30, AssetPaths.button__png, "PLAY",play);
		menuBtn = new util.Button(100, 185, 120, 30, AssetPaths.button__png, "MENU",menu);

		add(new FlxSprite(0, 0, AssetPaths.menubackground__png));
		add(text);
		add(head);
		add(playBtn);
		add(menuBtn);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}

	public function play(sprite:FlxSprite = null)
	{
		Reg.reset();
		FlxG.switchState(new states.PlayState());
	}

	public function menu(sprite:FlxSprite = null)
	{
		FlxG.switchState(new MenuState());
	}
}