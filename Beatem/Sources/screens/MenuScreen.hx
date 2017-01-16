package screens;

import sdg.Screen;
import actors.Player;
import actors.Enemy;
import actors.EnemyAI;
import kha.Assets;
import kha.Scheduler;

class MenuScreen extends Screen
{
	public function new()
	{
		super();
		add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));
		add(new Player(0,0,Assets.images.knight,32,32));
		//kha.Scheduler.addTimeTask(function(){add(new Enemy(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
//		kha.Scheduler.addTimeTask(function(){add(new EnemyAI(Math.random()*sdg.Sdg.gameWidth,Math.random()*sdg.Sdg.gameHeight,Assets.images.redknight,32,32));},1,2);
	}
}