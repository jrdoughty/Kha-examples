import kha.Image;
import kha2d.Scene;
import kha2d.Sprite;

class Pick 
{
	public var activeSprite:Sprite;
	public var value:Int;
	public var active = false;
	var pickImg:Image;
	var turnedImg:Image;
	var x:Float;
	var y:Float;
	

	public function new (value:Int, pickImg:Image, turnedImg:Image, x:Float = 0, y:Float = 0)
	{
		this.value = value;
		this.pickImg = pickImg;
		this.turnedImg = turnedImg;
		this.x = x;
		this.y = y;
		activeSprite = new Sprite(turnedImg,64,64,0);
		activeSprite.x = x;
		activeSprite.y = y;
		Scene.the.addOther(activeSprite);
	}

	public function turn()
	{
		if(active)
		{
			active = false;
			activeSprite.setImage(turnedImg);
		}
		else
		{
			active = true;
			activeSprite.setImage(pickImg);
		}
	}

	public function resetToNewVal(newVal:Int, newImage:Image)
	{
		value = newVal;
		active = false;
		activeSprite.setImage(turnedImg);
		pickImg = newImage;
	}
}