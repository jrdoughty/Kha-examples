package systems;
import components.Position;
import components.Player;
import kha.input.Keyboard;
import kha.input.KeyCode;
import kha.input.Mouse;

class Controls extends echoes.System
{
	public var left:Bool;
	public var right:Bool;
	public var up:Bool;
	public var down:Bool;
	public var speed:Int = 5;
	public var mouseDown:Bool = false;
	public var mouseX:Int;
	public var mouseY:Int;
    
    public function new() {
		Keyboard.get().notify(onKeyDown, onKeyUp);
		Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove,null);
    }
	@u inline public function update(pos:Position, p:Player)
	{
		if(up)
		{
			pos.y -= speed;
		}
		else if(down)
		{
			pos.y += speed;
		}

		if(left)
		{
			pos.x -= speed;
		}
		else if(right)
		{
			pos.x += speed;
		}
		if(mouseDown)
		{
			var diffX = mouseX - pos.x;
			var diffY = mouseY - pos.y;

			if(Math.abs(diffX) > speed)
			{
				if(diffX < 0)
				{
					pos.x -= speed;
				}
				else
				{
					pos.x += speed;
				}
			}
			else
			{
				pos.x += diffX;
			}

			if(Math.abs(diffY) > speed)
			{
				if(diffY < 0)
				{
					pos.y -= speed;
				}
				else
				{
					pos.y += speed;
				}
			}
			else
			{
				pos.y += diffY;
			}
		}
	}

	function onKeyDown(key:Int)
	{
		switch (key)
		{				
			case KeyCode.Left: left = true;
			case KeyCode.Right: right = true;
			case KeyCode.Up: up = true;
			case KeyCode.Down: down = true;
			case KeyCode.A: 
				left = true;
			case KeyCode.D: 
				right = true;
			case KeyCode.W: 
				up = true;
			case KeyCode.S: 
				down = true;
		}
	}
	function onKeyUp(key:Int)
	{
		switch (key)
		{				
			case KeyCode.Left: left = false;
			case KeyCode.Right: right = false;
			case KeyCode.Up: up = false;
			case KeyCode.Down: down = false;
			case KeyCode.A: 
				left = false;
			case KeyCode.D: 
				right = false;
			case KeyCode.W: 
				up = false;
			case KeyCode.S: 
				down = false;
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