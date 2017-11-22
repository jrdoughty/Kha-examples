package actors;

import kha2d.Sprite;
import kha.input.Keyboard;
import kha.Image;
import kha.input.KeyCode;
import kha2d.Animation;

class Player extends Sprite
{
	public var spriteCache:SpriteCache;
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
		mainAnim = new Animation([0,1,2,1], 5);
		charge = new Animation([3],12);
		spriteCache = new SpriteCache(this);
	}

	public function keyDown(key:Int)
	{
		if(key == KeyCode.Left || key == KeyCode.A)
		{
			if(scaleX > 0)
			{
				x += width;
			}
			scaleX = -1;
			left = true;
			setAnimation(mainAnim);
		}
		else if(key == KeyCode.Right || key == KeyCode.D)
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

	public function keyUp(key:Int)
	{
		if(key == KeyCode.Left || key == KeyCode.A)
		{
			left = false;
		}
		else if(key == KeyCode.Right || key == KeyCode.D)
		{
			right = false;
		}
	}

	public override function update ()
	{
		super.update();
		if(left && x > 0)
		{
			x -= 2;
		}
		else if(right && x < Reg.gameWidth/4*3)
		{
			x += 2;
		}
		else
		{
			setAnimation(idle);
		}
		spriteCache.update();
	}
}