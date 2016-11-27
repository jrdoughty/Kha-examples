package actors;

import kha2d.Sprite;
import kha.Image;
import kha.math.Vector2;
import verlet.Verlet;
import kha2d.Animation;
import kha.graphics2.Graphics;
import kha.Color;
import kha.math.FastMatrix3;

class Projectile extends Sprite
{
	public var point:ProjectilePoint;
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
		angle = 0;
	}

	public override function update()
	{
		super.update();
		if(point != null)
		{
			if(image.width == width)
			{
				var difx=x-point.composite.verts[0].x;
				var dify=y-point.composite.verts[0].y;

				var radius = Math.sqrt(difx * difx + dify * dify);
				trace(radius);
				angle = Math.acos(difx/radius)-Math.PI;

				trace(angle);
			}
			
			x = point.composite.verts[0].x;
			y = point.composite.verts[0].y;
		}
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