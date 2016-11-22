package actors;

import kha2d.Sprite;
import kha.Image;
import kha2d.Animation;
/**
 * ...
 * @author John Doughty
 */
class Goblin extends Sprite
{
	private var value:Int = 1;
	private var startY:Float;
	private var health:Float = 1;
	private var speed:Float;
	private var tag:String;
	private var tiredAnim:Animation;
	private var mainAnim:Animation;
	private var moves:Bool = true;

	public function new(image:Image, ?width:Int=0, ?height:Int,x:Float = 0, y:Float = 0, unitHealth:Float=1.0, value:Int = 1, speed:Float = .3, tag = 'goblin', ?anim:Animation,?tiredAnim:Animation)
	{
		super(image, width, height);
		this.x = x;
		this.y = y;
		this.speed = speed;
		scaleX = -1;
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
		Reg.counters[tag+"s_launched"] += 1;
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
			x -= speed;
		}
		super.update();
	}

	public function kill():Void
	{
		Reg.upgrades[getUnitTag()]["number"] -= 1;
		
		if (this.x >= 0 - width)
		{
			Reg.counters[getUnitTag() + "s_harmed"] += 1;
		}
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
}