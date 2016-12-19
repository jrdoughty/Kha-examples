package actors;

import kha2d.Sprite;
import kha.input.Keyboard;
import kha.Image;
import kha.Key;

class Player extends Sprite
{
	var left:Bool = false;
	var right:Bool = false;

	public function new (image:Image, ?width:Int=0, ?height:Int,x:Float = 0, y:Float = 0)
	{
		super(image, width, height);
		this.x = x;
		this.y = y;
		Keyboard.get().notify(keyDown,keyUp);
	}

	public function keyDown(key:Key, chars:String)
	{
		if(key == Key.LEFT || chars.indexOf("a") != -1)
		{
			left = true;
		}
		if(key == Key.RIGHT || chars.indexOf("d") != -1)
		{
			right = true;
		}
	}

	public function keyUp(key:Key, chars:String)
	{
		if(key == Key.LEFT || chars.indexOf("a") != -1)
		{
			left = false;
		}
		if(key == Key.RIGHT || chars.indexOf("d") != -1)
		{
			right = false;
		}
	}

	public override function update ()
	{
		if(left)
		{
			x -= 2;
		}
		if(right)
		{
			x += 2;
		}
	}
}