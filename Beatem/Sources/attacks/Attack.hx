package attacks;

import actors.Actor;
import sdg.collision.Hitbox;
import sdg.Object;

class Attack extends Object
{
	var hitbox:Hitbox;
	var dmg:Int;
	var actorOfOrigin:Actor;
	public function new (actor:Actor, direction:String)
	{
		super();
		actorOfOrigin = actor;
		dmg = actor.dmg;
		x = actor.x;
		y = actor.y;

		width = Std.int(actor.width/2);
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
			x += actor.width-1;
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
		if(Reflect.hasField(object,'health') && object != actorOfOrigin)
		{
			cast (object, Actor).health -= dmg;
		}
		return true;
	}

}