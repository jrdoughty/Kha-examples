package actors;

import kha2d.Sprite;
import kha.Image;
import kha2d.Animation;
import kha2d.Scene;
/**
 * ...
 * @author John Doughty
 */
class Goblin extends Sprite
{
	public var alive = true;
	private var value:Int = 1;
	private var startY:Float;
	private var health:Float = 1;
	private var speed:Float;
	private var tag:String;
	private var tiredAnim:Animation;
	private var mainAnim:Animation;
	private var moves:Bool = true;

	public function new(image:Image, ?width:Int=0, ?height:Int,x:Float = 0, y:Float = 0, unitHealth:Float=1.0, value:Int = 1, speed:Float = -.3, tag = 'goblin', ?anim:Animation,?tiredAnim:Animation)
	{
		super(image, width, height);
		this.x = x;
		this.y = y;
		this.speed = speed;
		if(speed < 0)
		{
			scaleX = -1;
		}
		health = unitHealth;
		this.value = value;
		this.tag = tag;
		if(anim != null)
		{
			mainAnim = anim;
		}
		else
		{
			mainAnim = new Animation([0, 1, 2, 1], 5);
		}
		setAnimation(mainAnim);
		if(tiredAnim != null)
		{
			this.tiredAnim = tiredAnim;
		}
		if(Reg.counters.exists(tag+"s_launched"))
		{
			Reg.counters[tag+"s_launched"] += 1;
		}
	}
	override public function update():Void
	{
		if (tiredAnim != null && (moves ? Math.random() <= .01 :Math.random() <= .03))
		{
			moves = !moves;
			setAnimation(moves ? mainAnim : tiredAnim );
		}
		if(moves)
		{
			x += speed;
		}
		if((x < 0 - width || x > Reg.gameWidth) && alive)
		{
			kill();
		}
		super.update();
	}

	public function kill():Void
	{
		if(Reg.inLevel)
		{
			if (x >= 0 - width && x < Reg.gameWidth)
			{
				Reg.upgrades[getUnitTag()]["number"] -= 1;
				Reg.counters[getUnitTag() + "s_harmed"] += 1;
				trace(getUnitTag() + " number: "+Reg.upgrades[getUnitTag()]["number"]);
				trace(getUnitTag() + " harmed: "+Reg.counters[getUnitTag() + "s_harmed"]);
			} 
			else if(alive)
			{
				
				Reg.score += getScore();
			}
		}
		Scene.the.removeHero(this);
		alive = false;
	}

	public function getScore():Int
	{
		//if (Type.getClass(FlxG.state) == PlayState)
		{
			return value;
		}
		//else
		{
			return 0;
		}
	}

	private function getTargetY()
	{
		return startY;
	}

	public function getUnitTag()
	{
		return tag;
	}
	public function damage(dmg:Int)
	{
		health -= dmg;
		if(health <= 0)
		{
			kill();
		}
	}
}