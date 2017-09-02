package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha.Image;
import kha2d.Scene;
import kha.input.Mouse;
import haxe.Timer;
import kha.Sound;
import kha.audio1.Audio;
import kha.audio1.AudioChannel;

class Project {

	var types:Array<Image> = [Assets.images.dragon, Assets.images.sword, Assets.images.logo, Assets.images.bot];
	var turnedDown:Image = Assets.images.turnedover;
	var pickData:Array<Int> = [0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1];
	var picks:Array<Pick> = [];
	var activePick:Pick = null;
	var turnTimer:Timer;
	var picked:Bool = false;
	var winText = "Pick to Start";
	var win:Bool = true;

	public function new() {
		System.notifyOnRender(render);
		
		Mouse.get().notify(onMouseDown, null, null, null);


		init();
	}

	function init()
	{

		createData(18);
		Scene.the.setSize(384,384);
		var sqr = Math.ceil(Math.sqrt(pickData.length));
		
		for(i in 0...pickData.length)
		{
			if(picks.length <= i)
			{
				picks.push(new Pick(pickData[i], types[pickData[i]], turnedDown, i % sqr * 64, Math.floor(i/sqr) * 64));
			}
			else
			{
				picks[i].resetToNewVal(pickData[i], types[pickData[i]]);
			}
		}
	}

	function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 64;
		graphics.drawString(winText, 56, 140);
		graphics.end();		
	}

	public function onMouseDown(button:Int, x:Int, y:Int)
	{
		if(button == 0)
		{
			if(win && winText == "You Win")
			{
				init();
				winText = "Pick to Start";
			}
			else
			{
				winText = "";
				for(i in picks)
				{
					if(!picked && x > i.activeSprite.x && x < i.activeSprite.x + i.activeSprite.width
					&& y > i.activeSprite.y && y < i.activeSprite.y + i.activeSprite.height)
					{
						i.turn();
						if(activePick == null)
						{
							activePick = i;
							Audio.play(Assets.sounds.pick);
						}
						else
						{
							if(activePick.value == i.value)
							{
								activePick = null;
								
								win = true;
								for(i in picks)
								{
									if(i.active == false)
									{
										win = false;
										break;
									}								
								}
								if(win && winText != "You Win")
								{
									winText = "You Win";
								}
								Audio.play(Assets.sounds.right);
							}
							else
							{
								turnTimer = new Timer(500);
								picked = true;
								turnTimer.run = function() {
									activePick.turn();
									i.turn();
									activePick = null;
									picked = false;
									turnTimer.stop();
									turnTimer = null;
									Audio.play(Assets.sounds.wrong);
								}
								Audio.play(Assets.sounds.wrong);
							}
						}
						break;
					}
				}
			}
		}
	}

	public function createData(pairs:Int)
	{
		var pickVal;
		var i;

		pickData = [];

		for(i in 0...pairs)
		{
			pickVal = i % types.length;
			pickData.insert(Math.floor(Math.random()*pickData.length), pickVal);
			pickData.insert(Math.floor(Math.random()*pickData.length), pickVal);
		}
	}
}
