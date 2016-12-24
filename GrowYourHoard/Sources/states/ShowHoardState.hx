
package states;

import actors.Goblin;
import util.Text;
import util.Button;
import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;
import actors.Projectile;
import kha2d.Animation;

/**
 * ...
 * @author John Doughty
 */
class ShowHoardState extends BaseState
{

	var score:Int = 0;
	var scoreText:Text;
	var coins:Array<Projectile> = [];

	public function new()
	{
	}

	public override function init():Void 
	{
		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		new Text("GROW YOUR", 42, 0, 40);
		new Text("HOARD", 90, 45, 40);
		scoreText = new Text("0 Gold",80, 100, 40);
		Scene.the.addOther(new Goblin(Assets.images.goblin1,20 ,20 ,250, 125,5,0,-.3));
		new Button(25, 155, 275, 80, new Sprite(Assets.images.button), "Invest", buy);
	}
	
	public function buy(?b:Int,?x:Int,?y:Int):Void
	{
		Project.the.changeState(new HoardState());
	}
	
	public override function kill():Void
	{
		super.kill();
		scoreText = null;
		for(i in coins)
		{
			i.kill();
		}
		coins = [];

	}
	
	public override function update():Void 
	{
		if (score < Reg.score && scoreText != null)
		{
			score++;
			scoreText.content = score+" Gold";
			trace(score);
			if(score<=50)
			{
				coins.push(new Projectile(Assets.images.coin,8,8,150 + Math.round(Math.random()*250) - 125, -100,new Animation([0],0), 0, 0));
				coins[coins.length-1].setScale(4);
			}
			Scene.the.addOther(coins[coins.length-1]);
		}
	}
	
}
