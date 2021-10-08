import kha2d.Sprite;
import kha2d.Animation;
import kha.Image;
import kha.System;

class Enemy extends Sprite
{
	public var speed:Float;

	public function new (image: Image, width: Int = 0, height: Int = 0, z: Int = 1)
	{
		super(image, width, height, z);
		reset();
		setAnimation(Animation.createRange(0,3,10*Math.floor(speed-1)));
	}

	public override function update()
	{
		super.update();
		y += speed;		
		
		if(y > System.windowHeight())
		{
			reset();
		}
	}

	public function setRandomSpeed()
	{
		speed = Math.random() * 5 + 2;
	}

	public function reset()
	{
		var scaleModifier = Math.random() * 3;
		y = -1 * height;
		x = Math.random() * System.windowWidth();
		scaleX = scaleModifier;
		scaleY = scaleModifier;
		setRandomSpeed();
	}
}