package actors;
import kha.Image;
import attacks.Attack;

class Enemy extends Actor
{

	var xAxis:Int;
	var yAxis:Int;
	var bAttacking:Bool = false;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		speed = .5;
		kha.Scheduler.addTimeTask(startMove,0,.25);
		startMove();
	}

	public function startMove()
	{
		var didMove:Bool = false;
		bAttacking = false;
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
			didMove = true;
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
			didMove = true;
		}
		if(!didMove)
		{
			bAttacking = true;	
			new Attack(this, sprite.flip.x?'left':'right');
		}
	}

	public override function update()
	{
		super.update();

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	

		motion.acceleration.x = speed * xAxis;
		motion.acceleration.y = speed * yAxis;

		sprite.flip.x = xAxis < 0;	
		if (bAttacking)	
		{	
			if(animator.nameAnim != 'attack')
				animator.play('attack', false);					
		}
		else if ((motion.velocity.x != 0 || motion.velocity.y != 0) && animator.nameAnim != 'run')	
		{		
			animator.play('run');					
		}
		else if (motion.velocity.x == 0 && motion.velocity.y == 0 && animator.nameAnim != 'idle')		
		{
			animator.play('idle');	
		}
		move();
	}	
}

