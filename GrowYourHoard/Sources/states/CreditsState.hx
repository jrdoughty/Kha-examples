package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import util.Button;
/**
 * ...
 * @author John Doughty
 */
class CreditsState extends FlxState
{
	var subHead:FlxText;
	var head:FlxText;
	var john:FlxText;
	var nick:FlxText;
	var goblins:FlxText;
	var greeds:FlxText;
	var ogres:FlxText;
	var extra:FlxText;
	var menuBtn:util.Button;
	
	override public function create():Void 
	{
		super.create();
		add(new FlxSprite(0, 0, AssetPaths.menubackground__png));

		subHead = new FlxText(0, 0, 320);
		subHead.text = "GROW YOUR";
		subHead.setFormat(AssetPaths.Our_Arcade_Games__ttf, 20, FlxColor.GOLDEN, "center");
		subHead.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		subHead.scale.set(.5, .5);
		add(subHead);

		head = new FlxText(0, 20, 320);
		head.text = "HOARD";
		head.setFormat(AssetPaths.Our_Arcade_Games__ttf, 20, FlxColor.GOLDEN, "center");
		head.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		add(head);

		john = new FlxText(0, 80, 320);
		john.text = "John Doughty Code and Art";
		john.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");
		john.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		john.scale.set(2, 2);
		add(john);

		nick = new FlxText(0, 55, 320);
		nick.text = "Nicholas Cash Code";
		nick.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");
		nick.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
		nick.scale.set(2, 2);
		add(nick);
		if (Reg.counters["goblins_harmed"] + Reg.counters["greedy_goblins_harmed"] +Reg.counters["ogres_harmed"] > 0)
		{
			goblins = new FlxText(-3, 108, 320);
			goblins.text = Reg.counters["goblins_harmed"] + " Goblins " + Reg.counters["greedy_goblins_harmed"] + " Greedy Goblins";
			goblins.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");
			goblins.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
			goblins.scale.set(2, 2);
			add(goblins);

			greeds = new FlxText(0, 133, 320);
			greeds.text = "and " +Reg.counters["ogres_harmed"]+" Ogres were harmed";
			greeds.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");
			greeds.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
			greeds.scale.set(2, 2);
			add(greeds);

			ogres = new FlxText(0, 158, 320);
			ogres.text = "growing your hoard";
			ogres.setFormat(AssetPaths.Our_Arcade_Games__ttf, 8, FlxColor.GOLDEN, "center");
			ogres.setBorderStyle(FlxText.BORDER_OUTLINE, FlxColor.BROWN, 1);
			ogres.scale.set(2, 2);
			add(ogres);
		}
		menuBtn = new util.Button(75, 180, 150, 50, AssetPaths.button__png, "Menu", menu, 27);
		add(menuBtn);
	}

	public function menu(sprite:FlxSprite)
	{
		FlxG.switchState(new MenuState());
	}
}