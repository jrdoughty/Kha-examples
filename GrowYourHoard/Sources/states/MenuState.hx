package states;

import kha2d.Sprite;
import util.Button;
import kha2d.Scene;
import kha.Assets;
import kha2d.Animation;
import Reg;
import util.Text;
import states.PlayState;

class MenuState implements IState
{
	var background:Sprite;
	var subHead:Text;
	var head:Text;
	var playBtn:Button;
	var helpBtn:Button;
	var creditsBtn:Button;
	var goblin:Sprite;
	var goblin2:Sprite;
	var idleAnim:Animation = Animation.createRange(0,1,12);
	public function new():Void
	{
	}

	public function init()
	{
		background = new Sprite(Assets.images.menubackground, 320, 240, 0);
		Scene.the.addOther(background);

		goblin = new Sprite(Assets.images.shieldwithgold,60,120);
		goblin.x = 20;
		goblin.y = 60;
		goblin.setAnimation(idleAnim);
		Scene.the.addOther(goblin);

		goblin2 = new Sprite(Assets.images.shieldwithgold,60,120);
		goblin2.x = 245;
		goblin2.y = 60;
		goblin2.setAnimation(idleAnim);
		Scene.the.addOther(goblin2);

		playBtn = new Button(100, 100, 120, 30, new Sprite(Assets.images.button), "PLAY", play, 18);

		helpBtn = new Button(100, 135, 120, 30, new Sprite(Assets.images.button), "HELP", help, 18);
		
		creditsBtn = new Button(100, 170, 120, 30, new Sprite(Assets.images.button), "Credits", credits, 18);

		subHead = new Text("GROW YOUR", 70, 0, 30);
		head = new Text("HOARD", 85, 35, 40);

	}

	public function play(b:Int,x:Int,y:Int)//sprite:FlxSprite = null)
	{
		Reg.reset();
		Project.the.changeState(new PlayState());
		kill();
	}

	public function help(b:Int,x:Int,y:Int)//sprite:FlxSprite = null)
	{
		//FlxG.switchState(new states.HelpState());
	}

	public function credits(b:Int,x:Int,y:Int)//sprite:FlxSprite = null)
	{
		//FlxG.switchState(new states.CreditsState());
	}
	public function kill():Void
	{
		Button.clear();
		playBtn = null;
		helpBtn = null;
		creditsBtn = null;
		Scene.the.removeOther(background);
		background = null;
		Scene.the.removeOther(goblin);
		goblin = null;
		Scene.the.removeOther(goblin2);
		goblin2 = null;
		Text.clear();
		subHead = null;
		head = null;
	}
}