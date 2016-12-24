package states;

import actors.Goblin;
import util.Text;
import util.Button;
import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;
import actors.Projectile;
import kha2d.Animation;

class WinState extends BaseState
{

	var score:Int = 0;
	var scoreText:Text;
	var coins:Array<Projectile> = [];
	var goblinSurvivors:Int;
	var greedyGoblinSurvivors:Int;
	var ogreSurvivors:Int;

	public function new()
	{
	}

	public override function init():Void 
	{
		goblinSurvivors = Reg.counters["goblins_launched"] - Reg.counters["goblins_harmed"];
		greedyGoblinSurvivors = Reg.counters["greedy_goblins_launched"] - Reg.counters["greedy_goblins_harmed"];
		ogreSurvivors = Reg.counters["ogres_launched"] - Reg.counters["ogres_harmed"];

		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		new Text("GROW YOUR", 42, 0, 40);
		new Text("HOARD", 90, 45, 40);
		scoreText = new Text("0 Gold",61, 100, 40);
		new util.Button(7, 180, 150, 50, new Sprite(Assets.images.button), "Menu", menu, 27);

		new util.Button(165, 180, 150, 50, new Sprite(Assets.images.button), "Credits", credits, 27);
	}

	public function menu(?b:Int,?x:Int,?y:Int)
	{
		Project.the.changeState(new MenuState());
	}

	public function credits(?b:Int,?x:Int,?y:Int)
	{
		Project.the.changeState(new CreditsState());
	}

	public override function update():Void
	{
		var g:Goblin;
		if (Math.random() <= .005 && ogreSurvivors > 0)
		{
			ogreSurvivors -= 1;
			g = new Goblin(Assets.images.ogre, 32, 64, 0, 113, 5, 1,.3);
			Scene.the.addHero(g);
		}

		if (Math.random() <= .005 && greedyGoblinSurvivors > 0)
		{
			greedyGoblinSurvivors -= 1;
			g = new Goblin(Assets.images.goblinbigbag, 20, 20,0, 153, 1, 3, .3, "greedy_goblin",null,new Animation([3,4,5,4], 5));
			Scene.the.addHero(g);
		}
		
		if (Math.random() <= .03 && goblinSurvivors > 0)
		{
			goblinSurvivors -= 1;
			g = new Goblin(Assets.images.goblin1, 20, 20, 0, 153, 1, 1,1);
			Scene.the.addHero(g);
		}


		if (score < Reg.score && scoreText != null)
		{
			score++;
			scoreText.content = score+" Gold";
			//if(score<=100)
			//{
				coins.push(new Projectile(Assets.images.coin,8,8,150 + Math.round(Math.random()*250) - 125, -100,new Animation([0],0), 0, 0));
				coins[coins.length-1].setScale(4);
			//}
			Scene.the.addOther(coins[coins.length-1]);
		}
		for(i in coins)
		{
			if(i.y > Reg.gameHeight)
			{
				i.kill();
				Scene.the.removeOther(i);
				coins.remove(i);
			}
		}
	}
}