package states;

import kha2d.Sprite;
import util.Button;
import kha2d.Scene;
import kha.Assets;
import kha2d.Animation;
import Reg;
import util.Text;
import states.PlayState;

class MenuState extends BaseState
{
	var goblin:Sprite;
	var goblin2:Sprite;
	var idleAnim:Animation = Animation.createRange(0,1,12);
	public function new():Void
	{
	}

	public override function init()
	{
		Scene.the.addOther(new Sprite(Assets.images.menubackground, 320, 240, 0));

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

		new Button(100, 100, 120, 30, new Sprite(Assets.images.button), "PLAY", play, 18);

		new Button(100, 135, 120, 30, new Sprite(Assets.images.button), "HELP", help, 18);
		
		new Button(100, 170, 120, 30, new Sprite(Assets.images.button), "Credits", credits, 18);

		new Text("GROW YOUR", 70, 0, 30);
		new Text("HOARD", 85, 35, 40);

	}

	public function play(b:Int,x:Int,y:Int)
	{
		Reg.reset();
		Project.the.changeState(new PlayState());
	}

	public function help(b:Int,x:Int,y:Int)
	{
		Project.the.changeState(new HelpState());
	}

	public function credits(b:Int,x:Int,y:Int)//sprite:FlxSprite = null)
	{
		Project.the.changeState(new CreditsState());
	}
	public override function kill():Void
	{
		super.kill();
		goblin = null;
		goblin2 = null;
	}

}