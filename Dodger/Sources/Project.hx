package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Assets;


class Project {

	var character:Sprite;
	public var numEnemys:Int = 25;
	public var score:Int = 0;
	public var enemys:Array<Enemy> = [];

	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		character = new Player(Assets.images.main,32,32,0);
		character.x = System.windowWidth()/2;
		character.y = System.windowHeight()-character.height;
		Scene.the.setSize(System.windowWidth(), System.windowHeight());
		Scene.the.addBackgroundTilemap(new kha2d.Tilemap(Assets.images.back,1024,768,[[0]]),0);
		Scene.the.addHero(character);
		var i;
		for(i in 0...numEnemys)
		{
			enemys.push(new Enemy(Assets.images.alt,32,32,0));
			Scene.the.addEnemy(enemys[i]);
		}
	}

	function update(): Void 
	{
		Scene.the.update();
		score++;

		var i;
		for(i in 0...enemys.length)
		{
			
			if(!(enemys[i].x > character.x + character.width || enemys[i].y > character.y + character.height || 
			character.x > enemys[i].x + enemys[i].width || character.y > enemys[i].y + enemys[i].height))
			{
				enemys[i].reset();
				score -= 50;
			}
		}
	}

	function render(framebuffer: Framebuffer): Void 
	{
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 48;
		graphics.drawString(score+"", 540, 32);
		graphics.end();		
	}
}
