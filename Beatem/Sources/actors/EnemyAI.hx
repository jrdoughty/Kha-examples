package actors;
import kha.Image;
import sdg.Object;
import attacks.Attack;
import kha.Scheduler;
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
	var attackDist:Int;
	var coolingDown:Bool = false;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		speed = 3;
		
		statesMap.set(IDLE, idle);
		statesMap.set(SAWPLAYER, sawPlayer);
		statesMap.set(CHASING, chasing);
		statesMap.set(ATTACKING, attacking);
		statesMap.set(FLEEING, fleeing);
		currentState = IDLE;
		attackDist = Std.int(width/2);
		enemies.push(this);
	}

	public override function update()
	{
		super.update();
		if(active)//failsafe
			statesMap[currentState]();
	}	
	public function idle()
    {
		if(animator.nameAnim != 'idle')
			animator.play('idle');
		for(i in Player.players)
		{
			if(getDistTo(i) < viewDist)
			{
				target = i;
				currentState = SAWPLAYER;
				break;
			}
		}
    }
    public function sawPlayer()
    {
		currentState = CHASING;//going to do nothing with this for now. Could always do a '!' overhead later
    }

	private function getDistTo(object:Object):Float
	{
		return Math.sqrt(Math.pow(Math.abs(object.x-x), 2) + Math.pow(Math.abs(object.y - y), 2));
	}

    public function chasing()
    {
		var targetX:Float; 
		if(target == null || !target.active)
		{
			target = null;
			currentState = IDLE;
		}
		else if(getDistTo(target) - (x<target.x?width:target.width) <= attackDist)
		{
			currentState = ATTACKING;
		}
		else
		{
			if(animator.nameAnim != 'run')
				animator.play('run');	

			if(target.x > x)
			{
				targetX = target.x - width;
				sprite.flip.x = false;
			}
			else
			{
				targetX = target.x + target.width;
				sprite.flip.x = true;
			}	
			
			//body.moveBy(motion.velocity.x, motion.velocity.y, 'collision');
			body.moveTowards(targetX,target.y,speed,'collision');
		}
    }
    public function attacking()
    {
		if(target == null || !target.active)
		{
			target = null;
			currentState = IDLE;
		}
		else if(getDistTo(target) - (x<target.x?width:target.width) <= attackDist )
		{
			if(!coolingDown)
			{
				new Attack(this, sprite.flip.x?'left':'right');
				animator.play('attack', false);	

				coolingDown = true;
				Scheduler.addTimeTask(coolDown,.5);

				if(!target.active)
					target = null;
			}
		}
		else
		{
			currentState = CHASING;
		}
	}

	private function coolDown()
	{
		coolingDown=false;
	}

    public function fleeing()
    {

    }

	public override function destroy()
	{
		super.destroy();
		enemies.remove(this);
	}
}

