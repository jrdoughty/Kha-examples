package attacks;

import actors.Actor;
import sdg.collision.Hitbox;
import sdg.Object;

class Attack extends Object
{
	var hitbox:Hitbox;
	var dmg:Int;
	public function new (actor:Actor, direction:String)
	{
		super();
		dmg = actor.dmg;
		x = actor.x;
		y = actor.y;


		width = actor.width;
		height = actor.height;
		hitbox = new Hitbox(this, null, 'collision');
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
		hitbox.destroy();
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