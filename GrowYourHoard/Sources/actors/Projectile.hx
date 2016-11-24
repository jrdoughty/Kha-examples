package actors;

import kha2d.Sprite;
import kha.Image;
import kha.math.Vector2;
import verlet.Verlet;
import kha2d.Animation;

class Projectile extends Sprite
{
	var point:ProjectilePoint;
	public function new(image:Image, width:Int, height:Int, spawnX:Float, spawnY:Float)
	{
		super(image, width, height);
		if(image.width != width || image.height != height)
		{
			trace('test' + (Math.floor(image.width/width * image.height/height)-1));
			setAnimation(Animation.createRange(0,Math.floor(image.width/width * image.height/height)-1, 5));
		}
		x = spawnX;
		y = spawnY;
		point = new ProjectilePoint(new Vector2(spawnX,spawnY));
		
	}

	public override function update()
	{
		super.update();
		x = point.composite.verts[0].x;
		y = point.composite.verts[0].y;
	}
}

class ProjectilePoint
{
	public var composite:Composite;
	public function new(pos:Vector2) 
	{
		composite = new Composite();
		composite.particles.push(new Particle(pos));
		Verlet.Instance.composites.push(composite);
	}
}