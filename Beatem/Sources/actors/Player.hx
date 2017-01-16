package actors;

import kha.Image;
import sdg.manager.Keyboard;
import sdg.manager.GamePads;
import attacks.Attack;

	


class Player extends Actor
{

	public static var players:Array<Player> = [];

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		dmg = 2;
		speed = .7;
		players.push(this);
	}

	public override function update()
	{
		super.update();
		var bMove = true;

		if(!active)//failsafe...
			return;

		if(Keyboard.isPressed(' ') || GamePads.get(0).buttonsPressed[GamePads.AX])
		{
			new Attack(this, sprite.flip.x?'left':'right');
		}

		if(Keyboard.isHeld(' ') || GamePads.get(0).buttonsHeld[GamePads.AX])
		{
			bMove = false;
			if(animator.nameAnim != 'attack')
  				animator.play('attack');
		}

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	
		if(bMove)
		{
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
			if ((motion.velocity.x != 0 || motion.velocity.y != 0) && animator.nameAnim != 'run')	
			{		
				animator.play('run');					
			}
			else if (motion.velocity.x == 0 && motion.velocity.y == 0 && animator.nameAnim != 'idle')		
			{
				animator.play('idle');	
			}
			move();
		}
	}

	public override function destroy()
	{
		super.destroy();
		players.remove(this);
	}
}

