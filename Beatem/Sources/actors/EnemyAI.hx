package actors;
import kha.Image;
import attacks.Attack;
enum EnemyState
{
	INITIALIZING;
	IDLE;
	SAWPLAYER;
	CHASING;
	ATTACKING;
	FLEEING;
}
class EnemyAI extends Actor
{
	public static var enemies:Array<EnemyAI> = [];
	var xAxis:Int;
	var yAxis:Int;
	var bAttacking:Bool = false;
	var currentState:EnemyState = INITIALIZING;
	var statesMap:Map<EnemyState, Void->Void> = new Map<EnemyState, Void->Void>();
	var target:Player = null;
	var viewDist:Int = 100;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		speed = .5;
		
		statesMap.set(IDLE, idle);
		statesMap.set(SAWPLAYER, sawPlayer);
		statesMap.set(CHASING, chasing);
		statesMap.set(ATTACKING, attacking);
		statesMap.set(FLEEING, fleeing);
		currentState = IDLE;

		enemies.push(this);
	}

	public override function update()
	{
		super.update();

		statesMap[currentState]();
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
	public function idle()
    {
		for(i in Player.players)
		{
			if(Math.sqrt(Math.pow(Math.abs(i.x-this.x), 2) + Math.pow(Math.abs(i.y - this.y), 2)) < viewDist)
			{
				target = i;
				currentState = SAWPLAYER;
				trace('stay on target');
				break;
			}
		}
    }
    public function sawPlayer()
    {

    }
    public function chasing()
    {

    }
    public function attacking()
    {

    }
    public function fleeing()
    {

    }
}

