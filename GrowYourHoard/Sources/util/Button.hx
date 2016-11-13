package util;

import kha.Font;
import kha2d.Sprite;
import kha2d.Scene;

class Button
{
	public var background:Sprite;
	public var text:Text;
	//public var clickRegion:FlxSprite;
	
	public var clickFunc:Dynamic;

	public function new(x:Float, y:Float, width:Int, height:Int, backgroundSprite:Sprite, textString:String, click:Dynamic,?fontSize:Int)
	{
		background = backgroundSprite;
		background.x = x;
		background.y = y;
		background.scaleX = width/background.width;
		background.scaleY = height/background.height;
		text = new Text(textString, Math.round(x + background.width/10), Math.round(y + background.height/10),Math.round(height*.66));
		Scene.the.addOther(background);
		clickFunc = click;
	}
/*
	public function over(sprite:FlxSprite)
	{
		
	}

	public function out(sprite:FlxSprite)
	{
		
	}
*/	
	public function update():Void 
	{
		//super.update();
	}
}