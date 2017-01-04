package actors;

import kha.Image;
import sdg.manager.Keyboard;
import sdg.manager.GamePads;

class Player extends Actor
{

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		speed = .7;
	}

	public override function update()
	{

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	

		if (Keyboard.isHeld('a') || Keyboard.isHeld('left') || GamePads.get(0).leftAnalog.x < -.5 || GamePads.get(0).buttonsHeld.get(GamePads.DLEFT))
		{
			motion.acceleration.x = -speed;
			sprite.flip.x = true;	
		}            
        else if (Keyboard.isHeld('d') || Keyboard.isHeld('right') || GamePads.get(0).leftAnalog.x > .5 || GamePads.get(0).buttonsHeld.get(GamePads.DRIGHT))
		{		
			motion.acceleration.x = speed;
			sprite.flip.x = false;
		}

		if (Keyboard.isHeld('s') || Keyboard.isHeld('down') || GamePads.get(0).leftAnalog.y < -.5 || GamePads.get(0).buttonsHeld.get(GamePads.DDOWN))
		{
			motion.acceleration.y = speed;
		}            
        else if (Keyboard.isHeld('w') || Keyboard.isHeld('up') || GamePads.get(0).leftAnalog.y > .5 || GamePads.get(0).buttonsHeld.get(GamePads.DUP))
		{		
			motion.acceleration.y = -speed;
		}


		super.update();
	}
}

