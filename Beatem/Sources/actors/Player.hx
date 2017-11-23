package actors;

import kha.Image;
import sdg.manager.Keyboard;
import sdg.manager.GamePad;
import kha.input.KeyCode;
import attacks.Attack;


class Player extends Actor
{

	public static var players:Array<Player> = [];
	private var playerIndex = 0;

	public function new(x:Float, y:Float,i:Image,w:Int,h:Int)
	{
		super(x, y, i, w, h);
		health = 10;
		dmg = 1;
		speed = .7;
		players.push(this);
		playerIndex = players.length-1;
	}

	public override function update()
	{
		super.update();
		var bMove = true;


		bMove = processAttackInput();

		motion.acceleration.x = 0;	
		motion.acceleration.y = 0;	
		if(bMove)
		{
			processMoveInput();

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

	private function processAttackInput():Bool
	{
		if(Keyboard.isPressed(KeyCode.Space) || GamePad.get(playerIndex).isPressed(GamePad.A_X))
		{
			new Attack(this, sprite.flip.x?'left':'right');
		}

		if(Keyboard.isHeld(KeyCode.Space) || GamePad.get(playerIndex).isHeld(GamePad.A_X))
		{
			if(animator.nameAnim != 'attack')
  				animator.play('attack');
			
			return false;
		}
		else
			return true;
	}

	private function processMoveInput()
	{
			if (Keyboard.isHeld(KeyCode.A) || Keyboard.isHeld(KeyCode.Left) || GamePad.get(playerIndex).leftAnalog.x < -.5 || GamePad.get(playerIndex).isHeld(GamePad.DLEFT))
			{
				motion.acceleration.x = -speed;
				sprite.flip.x = true;	
			}            
			else if (Keyboard.isHeld(KeyCode.D) || Keyboard.isHeld(KeyCode.Right) || GamePad.get(playerIndex).leftAnalog.x > .5 || GamePad.get(playerIndex).isHeld(GamePad.DRIGHT))
			{		
				motion.acceleration.x = speed;
				sprite.flip.x = false;
			}

			if (Keyboard.isHeld(KeyCode.S) || Keyboard.isHeld(KeyCode.Down) || GamePad.get(playerIndex).leftAnalog.y < -.5 || GamePad.get(playerIndex).isHeld(GamePad.DDOWN))
			{
				motion.acceleration.y = speed;
			}            
			else if (Keyboard.isHeld(KeyCode.W) || Keyboard.isHeld(KeyCode.Up) || GamePad.get(playerIndex).leftAnalog.y > .5 || GamePad.get(playerIndex).isHeld(GamePad.DUP))
			{		
				motion.acceleration.y = -speed;
			}
	}

	public override function destroy()
	{
		super.destroy();
		players.remove(this);
	}
}

