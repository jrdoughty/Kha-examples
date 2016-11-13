package util;
import kha.graphics2.Graphics;
import kha.Framebuffer;
import kha.Color;
import kha.Font;
import kha.Assets;

class Text
{
	public static var texts:Array<Text> = [];
	public var x:Float;
	public var y:Float;
	public var fontSize:Int;
	public var content:String;
	public var font:Font;
	public var color:Color;

	public function new(text:String, x:Float = 0, y:Float = 0, size:Int = 16, ?font:Font, ?color:Color)
	{
		content = text;
		this.x = x;
		this.y = y;
		fontSize = size;
		texts.push(this);
		if(font != null)
		{
			this.font = font;
		}
		else
		{
			this.font = Assets.fonts.OurArcadeGames;
		}
		if(color != null)
		{
			this.color = color;
		}
		else
		{
			this.color = Color.fromValue(0xffffd700);
		}
	}

	public function render(graphics: Graphics)
	{
		graphics.color = color;
		graphics.font = font;
		graphics.fontSize = fontSize;
		graphics.drawString(content, x, y);
	}
}