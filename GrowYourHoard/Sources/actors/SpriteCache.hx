package actors;
import kha2d.Sprite;

class SpriteCache 
{
	var arraySprites:Array<Sprite> = [];
	var sprite:Sprite;
	var lastX:Float;
	var lastY:Float;
	var lastScaleX:Float;
	var lastScaleY:Float;
	public function new(s:Sprite)
	{
		sprite = s;
		lastX = s.x;
		lastY = s.y;
		lastScaleX = s.scaleX;
		lastScaleY = s.scaleY;

	}

	public function update()
	{
		for(i in arraySprites)
		{
			if(sprite.scaleX != lastScaleX)
			{
				i.x -= (i.x - lastX)*2;
				i.angle *= -1;
			}
			if(sprite.scaleY != lastScaleY)
			{
				i.y -= (i.y - lastY)*2;
			}
			i.x += sprite.x - lastX;
			i.x += sprite.y - lastY;
			i.scaleX = sprite.scaleX;
			i.scaleY = sprite.scaleY;
		}
		lastX = sprite.x;
		lastY = sprite.y;
		lastScaleX = sprite.scaleX;
		lastScaleY = sprite.scaleY;
	}

	public function addSprite(s)
	{
		arraySprites.push(s);
	}
}