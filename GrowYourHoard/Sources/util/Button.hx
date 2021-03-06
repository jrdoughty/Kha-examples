package util;

import kha.Font;
import kha2d.Sprite;
import kha2d.Scene;

class Button
{
	public static var buttons:Array<Button> = [];
	public var background:Sprite;
	public var text:Text;
	//public var clickRegion:FlxSprite;
	
	public var click:Int->Int->Int->Void;

	public function new(x:Float, y:Float, width:Int, height:Int, backgroundSprite:Sprite, textString:String, click:Int->Int->Int->Void,?fontSize:Int)
	{
		background = backgroundSprite;
		background.x = x;
		background.y = y;
		background.scaleX = width/background.width;
		background.scaleY = height/background.height;
		text = new Text(textString, Math.round(x + background.width/10), Math.round(y + background.height/10),fontSize==null?Math.round(height*.66):fontSize);
		Scene.the.addOther(background);
		this.click = click;
		buttons.push(this);
	}


	public function kill()
	{
		if(!background.removed && background != null)
		{
			Scene.the.removeOther(background);
		}
		background = null;
		text.kill();
	}

	public static function clear()
	{
		for(i in buttons)
		{
			i.kill();
		}
		buttons = [];
	}

	
/*
	public function over(sprite:FlxSprite)
	{
		
	}

	public function out(sprite:FlxSprite)
	{
		
	}
	public function update():Void 
	{
		//super.update();
	}
*/	
}