package actors;

import kha2d.Sprite;
import kha.input.Keyboard;
import kha.Image;
import kha.Key;
import kha2d.Animation;

class Player extends Sprite
{
	var left:Bool = false;
	var right:Bool = false;
	var idle:Animation;
	var mainAnim:Animation;
	var charge:Animation;

	public function new (image:Image, ?width:Int=0, ?height:Int,x:Float = 0, y:Float = 0)
	{
		super(image, width, height);
		this.x = x;
		this.y = y;
		Keyboard.get().notify(keyDown, keyUp);
		idle = new Animation([0], 12);
		mainAnim = new Animation([0,1,2], 5);
		charge = new Animation([3],12);
	}

	public function keyDown(key:Key, chars:String)
	{
		if(key == Key.LEFT || chars.indexOf("a") != -1)
		{
			if(scaleX > 0)
			{
				x += width;
			}
			scaleX = -1;
			left = true;
			setAnimation(mainAnim);
		}
		else if(key == Key.RIGHT || chars.indexOf("d") != -1)
		{
			if(scaleX < 0)
			{
				x += width;
			}
			scaleX = 1;
			right = true;
			setAnimation(mainAnim);
		}
	}

	public function keyUp(key:Key, chars:String)
	{
		if(key == Key.LEFT || chars.indexOf("a") != -1)
		{
			left = false;
		}
		else if(key == Key.RIGHT || chars.indexOf("d") != -1)
		{
			right = false;
		}
	}

	public override function update ()
	{
		super.update();
		if(left)
		{
			x -= 2;
		}
		else if(right)
		{
			x += 2;
		}
		else
		{
			setAnimation(idle);
		}
	}
}