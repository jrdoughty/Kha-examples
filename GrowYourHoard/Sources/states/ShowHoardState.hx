
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
class ShowHoardState implements IState
{

	var score:Int = 0;
	var subHead:Text;
	var head:Text;
	var scoreText:Text;
	var buyBtn:util.Button;
	var coins:Array<Projectile> = [];

	public function new()
	{
	}

	public function init():Void 
	{
		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		subHead = new Text("GROW YOUR", 42, 0, 40);
		head = new Text("HOARD", 90, 45, 40);
		scoreText = new Text("0 Gold",80, 100, 40);
		Scene.the.addOther(new Goblin(Assets.images.goblin1,20 ,20 ,250, 125,5,0,3));
		buyBtn = new Button(25, 155, 275, 80, new Sprite(Assets.images.button), "Invest", buy);
	}
	
	public function buy(?b:Int,?x:Int,?y:Int):Void
	{
		kill();
	}
	
	public function kill():Void
	{
		Text.clear();
		subHead = null;
		head = null;
		scoreText = null;
		buyBtn.kill();
		buyBtn = null;
		for(i in coins)
		{
			i.kill();
		}
		coins = [];
		Scene.the.clear();

		Project.the.changeState(new HoardState());
	}
	
	public function update():Void 
	{
		if (score < Reg.score && scoreText != null)
		{
			score++;
			scoreText.content = score+" Gold";
			coins.push(new Projectile(Assets.images.coin,8,8,150 + Math.round(Math.random()*250) - 125, -100,new Animation([0],0), 0, 0));
			coins[coins.length-1].setScale(4);
			Scene.the.addOther(coins[coins.length-1]);
		}
	}
	
}
