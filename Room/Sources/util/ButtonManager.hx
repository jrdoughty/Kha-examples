package util;

import util.Button;
import kha.input.Mouse;

class ButtonManager
{

	public static var the(get, null):ButtonManager;

	private static function get_the()
	{
		if(the == null)
		{
			the = new ButtonManager();
		}
		return the;
	}

	public function new(?btns:Array<Button>)
	{
		Mouse.get().notify(down, up, move, scroll);
	}

	public function down(mButton:Int, x:Int, y:Int)
	{
		for(i in Button.buttons)
		{
			if(i.background != null && i.background.visible && 
			i.background.x <= x &&i.background.x + i.background.width >= x && 
			i.background.y <= y &&i.background.y + i.background.height >= y)
			{
				i.click(mButton, x, y);
				break;
			}
		}
	}
	public function up(mButton:Int, x:Int, y:Int)
	{
	}	
	public function move(x:Int,y:Int,cx:Int,cy:Int)
	{

	}
	public function scroll(scroll:Int)
	{

	}
}