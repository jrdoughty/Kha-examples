package;

import systems.Animation;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import echoes.Entity;
import components.*;
import echoes.Workflow;

class Project {
	var characterEcho:Entity;
	public var numEnemys:Int = 100;
	public var score:Int = 0;
	public var fps:Int = 0;
	public var enemys:Array<Enemy> = [];
	public var enemiesEcho:Array<Entity> = [];

	public function new() 
	{
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		Scheduler.addTimeTask(secondTick, 0, 1);
		var images = Assets.images;
		characterEcho = new Entity().add(
			new Position(Main.WIDTH /2 , Main.HEIGHT-Main.HEIGHT/5),
			new Velocity(0,0),
			new components.Player(),
			new ImageComp(images.main)
		);
		var i;
		for(i in 0...numEnemys)
		{
			var speed = (Math.random()+.5)*40;
			enemiesEcho.push(new Entity().add(
				new Position(Main.WIDTH * Math.random(), 0),
				new Velocity(0,(Math.random()+.5)*40),
				new components.Enemy(),
				new Scale(Math.random()*3),
				new ImageComp(images.alt),
				AnimComp.createAnimDataRange(0,3,Math.round(speed)),
				new WH(32,32)
			));
		}
	}

	function update(): Void 
	{
		Workflow.update(60 / 1000);
	}

	function secondTick(): Void 
	{
		fps = score;
		score = 0;
	}
	function render(framebuffer: Framebuffer): Void 
	{
		var graphics = framebuffer.g2;
		graphics.begin();
		//Scene.the.render(graphics);Assets.images.back
		
		graphics.drawScaledImage(Assets.images.back,0,0,Main.WIDTH,Main.HEIGHT);
		for(i in enemiesEcho)
		{
			Animation.render(graphics,i.get(AnimComp),i.get(ImageComp),i.get(WH),i.get(Position),i.get(Scale));
		}
		graphics.drawSubImage(characterEcho.get(ImageComp).value, characterEcho.get(Position).x, characterEcho.get(Position).y, 0, 0, 32, 32);
		//graphics.drawRect()
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 48;
		graphics.drawString(fps+"", 540, 32);
		graphics.end();	
		
		score++;
	}
}
