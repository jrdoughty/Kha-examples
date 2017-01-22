package collision;
import sdg.Object;
import sdg.collision.Hitbox;

class Wall extends Object
{

	var body:Hitbox;

	public function new(x:Float, y:Float,w:Int,h:Int)
	{
		super(x, y);
		width = w;
		height = h;
		body = new Hitbox(this, null, 'collision');
	}

}