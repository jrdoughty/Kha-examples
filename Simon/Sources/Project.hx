package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;
import kha2d.Animation;
import kha.Image;
import kha.input.Mouse;
import haxe.Timer;
import kha.Sound;
import kha.audio1.Audio;
import kha.audio1.AudioChannel;

class Project {

	var picks:Array<Sprite> = [];
	var brighten:Animation = Animation.create(2);
	var darken:Animation = Animation.create(1);
	var norm:Animation = Animation.create(0);
	var sequenceToMatch:Array<Sprite> = [];
	var sequenceOfPlayer:Array<Sprite> = [];
	var disableInput:Bool = true;
	var timer:Timer;
	var showBeep:Sound;
	var wrongBeep:Sound;
	var beep:Sound;
	var audioChannel:AudioChannel;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		var i;
		var ai = Assets.images;
		var images:Array<Image> = [ai.green,ai.blue,ai.red,ai.yellow];

		showBeep = Assets.sounds.Pickup_Coin15;
		beep = Assets.sounds.Pickup_Coin30;
		wrongBeep = Assets.sounds.Explosion;

		for(i in 0...4)
		{
			picks.push(new Sprite(images[i],64,64,0));
			picks[i].x = i % 2 * 64;
			picks[i].y = Math.floor(i/2) * 64;
			Scene.the.addOther(picks[i]);
		}
		Mouse.get().notify(onMouseDown, onMouseUp, null, null);
		addNewPickToSequence();
	}

	public function addNewPickToSequence()
	{
		sequenceOfPlayer = [];
		sequenceToMatch.push(picks[Math.floor(picks.length * Math.random())]);
		disableInput = true;
		timer = new Timer(1000);
		var i = -1;
		var t:Timer;
		timer.run = function(){
			i++;
			if(i != sequenceToMatch.length)
			{
				sequenceToMatch[i].setAnimation(darken);
				Audio.play(showBeep, false);
				t = new Timer(500);
				t.run = function(){
					sequenceToMatch[i].setAnimation(norm);
					t.stop();
				}
			}
			else
			{
				disableInput = false;
				timer.stop();
			}
		}
	}

	public function reset()
	{
		sequenceToMatch = [];
		Audio.play(wrongBeep, false);
		addNewPickToSequence();
	}

	public function onMouseDown(button:Int, x:Int, y:Int)
	{
		if(button == 0 && !disableInput)
		{
			for(i in picks)
			{
				if(x > i.x && x < i.x + i.width
				&& y > i.y && y < i.y + i.height)
				{
					i.setAnimation(brighten);
					sequenceOfPlayer.push(i);
					var j;
					var win = true;
					for(j in 0...sequenceOfPlayer.length)
					{
						if(!(sequenceOfPlayer[j] == sequenceToMatch[j]))
						{
							win = false;
						}
					}
					if(win && sequenceOfPlayer.length == sequenceToMatch.length)
					{
						addNewPickToSequence();
					}
					
					if(!win)
					{
						reset();
					}
					else
					{
						Audio.play(beep, false);
					}
				}
			}
		}
	}

	public function onMouseUp(button:Int, x:Int, y:Int)
	{
		if(button == 0)
		{
			for(i in picks)
			{
				i.setAnimation(norm);
			}
		}
	}

	function update(): Void {
		
	}

	function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 64;
		graphics.drawString((sequenceToMatch.length-1)+"", 52, 32);
		graphics.end();
	}
}
