package actors;
import sdg.Object;
import kha.Image;
import sdg.atlas.Atlas;
import sdg.graphics.Sprite;
import sdg.atlas.Region;
import sdg.components.Motion;
import sdg.components.Animator;
import sdg.collision.Hitbox;


class Enemy extends Actor
{

	var xAxis:Int;
	var yAxis:Int;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		speed = .5;
		kha.Scheduler.addTimeTask(move,0,.25);
		move();
	}

	public function move()
	{
		xAxis = 0;
		yAxis = 0;
		if(Math.random()>=.85)
		{
			if(Math.random()<.5)
			{
				xAxis = -1;
			} 
			else
			{
				xAxis = 1;
			}
		}
		if(Math.random() >=.85)
		{
			if(Math.random()<.5)
			{
				yAxis = -1;
			} 
			else
			{
				yAxis = 1;
			}
		}
	}

	public override function update()
	{

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	

		motion.acceleration.x = speed * xAxis;
		motion.acceleration.y = speed * yAxis;

		sprite.flip.x = xAxis < 0;	
		super.update();
	}	
}

