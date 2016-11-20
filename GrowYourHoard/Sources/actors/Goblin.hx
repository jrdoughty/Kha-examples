package actors;

import kha2d.Sprite;
import kha.Image;

/**
 * ...
 * @author John Doughty
 */
class Goblin extends Sprite
{
	private var value:Int = 1;
	private var startY:Float;
	private var health:Float = 1;

	public function new(image:Image, ?width:Int=0, ?height:Int,x:Float = 0, y:Float = 0, unitHealth:Float=1.0, value:Int = 1)
	{
		super(image, width, height);
		this.x = x;
		this.y = y;
		scaleX = -1;
		health = unitHealth;
		this.value = value;
		setup();
	}

	private function setup()
	{
		
		//animation.add("main", [0, 1, 2, 1], 12, true);
		//animation.play("main");

		Reg.counters["goblins_launched"] += 1;

		//FlxVelocity.moveTowardsPoint(this, new FlxPoint(0 - width, y), 60);
	}

	override public function update():Void
	{
		super.update();
		x--;
		if (this.x < 0 - width)
		{
			Reg.score += getScore();
		}
	}

	public function kill():Void
	{
		Reg.upgrades[getUnitTag()]["number"] -= 1;
		
		if (this.x >= 0 - width)
		{
			Reg.counters[getUnitTag() + "s_harmed"] += 1;
		}
	}

	private function getScore():Int
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

	private function getUnitTag()
	{
		return "goblin";
	}
}