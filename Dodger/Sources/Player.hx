import kha2d.Sprite;
import kha.input.Keyboard;
import kha.Image;
import kha.Key;
import kha.input.Mouse;

class Player extends Sprite
{
	public var left:Bool;
	public var right:Bool;
	public var up:Bool;
	public var down:Bool;
	public var speed:Int = 5;
	public var mouseDown:Bool = false;
	public var mouseX:Int;
	public var mouseY:Int;

	public function new (image: Image, width: Int = 0, height: Int = 0, z: Int = 1)
	{
		super(image, width, height, z);
		Keyboard.get().notify(onKeyDown, onKeyUp);
		Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove,null);
	}
	
	public override function update()
	{
		super.update();
		if(up)
		{
			y -= speed;
		}
		else if(down)
		{
			y += speed;
		}

		if(left)
		{
			x -= speed;
		}
		else if(right)
		{
			x += speed;
		}
		if(mouseDown)
		{
			var diffX = mouseX - x;
			var diffY = mouseY - y;

			if(Math.abs(diffX) > speed)
			{
				if(diffX < 0)
				{
					x -= speed;
				}
				else
				{
					x += speed;
				}
			}
			else
			{
				x += diffX;
			}

			if(Math.abs(diffY) > speed)
			{
				if(diffY < 0)
				{
					y -= speed;
				}
				else
				{
					y += speed;
				}
			}
			else
			{
				y += diffY;
			}
		}
	}

	function onKeyDown(key:Key, char:String)
	{
		switch (key){
			case LEFT: left = true;
			case RIGHT: right = true;
			case UP: up = true;
			case DOWN: down = true;
		default: switch (char)
				{
					case 'a': 
						left = true;
					case 'd': 
						right = true;
					case 'w': 
						up = true;
					case 's': 
						down = true;
				}
		}
	}
	function onKeyUp(key:Key, char:String)
	{
		switch (key){
			case LEFT: left = false;
			case RIGHT: right = false;
			case UP: up = false;
			case DOWN: down = false;
		default: switch (char)
				{
					case 'a': 
						left = false;
					case 'd': 
						right = false;
					case 'w': 
						up = false;
					case 's': 
						down = false;
				}
		}
	}
	function onMouseDown(button:Int, mX:Int, mY:Int)
	{
		if(button == 0)
		{
			mouseDown = true;
		}
		mouseX = mX;
		mouseY = mY;
	}
	function onMouseUp(button:Int, mX:Int, mY:Int)
	{
		if(button == 0)
		{
			mouseDown = false;
		}
		mouseX = mX;
		mouseY = mY;
	}
	function onMouseMove(mX:Int, mY:Int, mCX:Int, mCY:Int)
	{
		mouseX = mX;
		mouseY = mY;
	}
}