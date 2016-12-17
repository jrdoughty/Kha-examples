package actors;

import kha2d.Sprite;
import kha.Image;
import kha.math.Vector2;
import verlet.Verlet;
import verlet.Objects;
import kha2d.Animation;
import kha.graphics2.Graphics;
import kha.Color;
import kha.math.FastMatrix3;

class Projectile extends Sprite
{
	public var point:ProjectilePoint;
	public var deadAnim:Animation;
	public function new(image:Image, width:Int, height:Int, spawnX:Float, spawnY:Float, deadAnim:Animation)
	{
		super(image, width, height);
		if(image.width != width || image.height != height)
		{
			trace('test' + (Math.floor(image.width/width * image.height/height)-1));
			setAnimation(Animation.createRange(0,Math.floor(image.width/width * image.height/height)-1, 5));
			this.deadAnim = deadAnim;
		}
		else
		{
			this.deadAnim = new Animation([0],0);
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
				angle = Math.acos(difx/radius)*-1+Math.PI/4;
			}

			x = point.composite.verts[0].x;
			y = point.composite.verts[0].y;
		}
	}

}

class ProjectilePoint extends Point
{
	public function new(pos:Vector2) 
	{
		super(pos);
		var yV = Math.random()*10;
		var xV = Math.random()*4+1;
		
		for(i in composite.particles)
		{
			i.lastPos =new Vector2(pos.x+xV,pos.y+yV);
		}
		
	}

	public function destroy()
	{
		Verlet.Instance.composites.remove(composite);
		composite = null;
	}
}