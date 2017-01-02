package actors;

import sdg.Object;
import sdg.Graphic;
import kha.Image;
import sdg.atlas.Atlas;
import sdg.graphics.Sprite;
import sdg.atlas.Region;
import sdg.components.Motion;
import sdg.components.Animator;
import sdg.manager.Keyboard;
import sdg.manager.GamePads;
import sdg.collision.Hitbox;

class Player extends Object
{
	var sprite:Sprite;	
	var motion:Motion;
	var animator:Animator;
	var body:Hitbox;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y);

		layer = 3;

		var regions = Atlas.createRegionsFromAsset(i, 32, 32);
		
		sprite = new Sprite(regions[0]);
		graphic = sprite;

		//setSizeAuto();
		//halfWidth = Std.int(width / 2);

		body = new Hitbox(this, 'play');
		
		setupAnimations(regions);
		
		motion = new Motion();
		motion.drag.x = 0.5;
		motion.drag.y = 0.5;
		motion.maxVelocity.x = 3;
		motion.maxVelocity.y = 3;
		//motion.acceleration.y = 0.3;
		addComponent(motion);
	}

	function setupAnimations(regions:Array<Region>)
	{
		animator = new Animator();
		animator.addAnimation('idle', [regions[0]]);
		animator.addAnimation('run', regions.slice(0, 2), 5);
		animator.addAnimation('attack', [regions[0],regions[2]], 5);

		addComponent(animator);

		animator.play('idle');
	}

	public override function update()
	{
		super.update();

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	

		if (Keyboard.isHeld('a') || Keyboard.isHeld('left') || GamePads.get(0).leftAnalog.x < -.5 || GamePads.get(0).buttonsHeld.get(GamePads.DLEFT))
		{
			motion.acceleration.x = -0.7;
			sprite.flip.x = true;	
		}            
        else if (Keyboard.isHeld('d') || Keyboard.isHeld('right') || GamePads.get(0).leftAnalog.x > .5 || GamePads.get(0).buttonsHeld.get(GamePads.DRIGHT))
		{		
			motion.acceleration.x = 0.7;
			sprite.flip.x = false;
		}

		if (Keyboard.isHeld('s') || Keyboard.isHeld('down') || GamePads.get(0).leftAnalog.y < -.5 || GamePads.get(0).buttonsHeld.get(GamePads.DDOWN))
		{
			motion.acceleration.y = 0.7;
		}            
        else if (Keyboard.isHeld('w') || Keyboard.isHeld('up') || GamePads.get(0).leftAnalog.y > .5 || GamePads.get(0).buttonsHeld.get(GamePads.DUP))
		{		
			motion.acceleration.y = -0.7;
		}

		if(Math.abs(motion.acceleration.y) > 0 && Math.abs(motion.acceleration.x) > 0)
		{
			motion.acceleration.y *= Math.sqrt(2);
			motion.acceleration.x *= Math.sqrt(2);
		}

		body.moveBy(motion.velocity.x, motion.velocity.y, 'collision');

		if ((motion.velocity.x != 0 || motion.velocity.y != 0) && animator.nameAnim != 'run')	
		{		
			trace('run');
			animator.play('run');					
		}
		else if (motion.velocity.x == 0 && motion.velocity.y == 0 && animator.nameAnim != 'idle')		
		{
				animator.play('idle');	
		}
	}	
}

