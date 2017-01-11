package attacks;

import actors.Actor;
import sdg.collision.Hitbox;
import sdg.Object;

class Attack extends Object
{
	var hitbox:Hitbox;
	var dmg:Int;
	public function new (twoDObject:Actor, direction:String)
	{
		super();
		dmg = twoDObject.dmg;
		x = twoDObject.x;
		y = twoDObject.y;


		width = twoDObject.width;
		height = twoDObject.height;
		hitbox = new Hitbox(this,'play', null, 'collision');
		var d = direction.toLowerCase();
		sdg.Sdg.screen.add(this);
		screen = sdg.Sdg.screen;
		if(d == 'left')
		{
			x -= width-1;
			hitbox.moveBy(-1, 0, 'collision');
		}
		else if(d == 'right')
		{
			x += width-1;
			hitbox.moveBy(width + 1, 0, 'collision');
		}
		this.destroy();
	}	
	public override function destroy()
	{
		screen.remove(this);
		active = false;
		hitbox.destroy('play','collision');
	}

	public override function moveCollideX(object:Object):Bool
	{
		if(Reflect.hasField(object,'health'))
		{
			cast (object, Actor).health -= dmg;
		}
		return true;
	}

}