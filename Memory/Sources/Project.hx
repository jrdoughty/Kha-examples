package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha.Image;
import kha2d.Scene;
import kha.input.Mouse;
import haxe.Timer;

class Project {

	var types:Array<Image> = [Assets.images.dragon, Assets.images.sword, Assets.images.logo, Assets.images.bot];
	var turnedDown:Image = Assets.images.turnedover;
	var pickData:Array<Int> = [0,0,1,1,2,2,3,3,0,0,1,1,2,2,3,3,0,0,1,1];
	var picks:Array<Pick> = [];
	var activePick:Pick = null;
	var turnTimer:Timer;
	var picked:Bool = false;
	var winText = "";
	

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		createData(8);
		Scene.the.setSize(256,256);
		var i;
		var sqr = Math.ceil(Math.sqrt(pickData.length));
		
		for(i in 0...pickData.length)
		{
			picks.push(new Pick(pickData[i], types[pickData[i]], turnedDown, i % sqr * 64, Math.floor(i/sqr) * 64));
		}
		Mouse.get().notify(onMouseDown,onMouseUp,onMouseMove, null);

	}

	function update(): Void {
		
	}

	function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 64;
		graphics.drawString(winText, 32, 96);
		graphics.end();		
	}

	public function onMouseDown(button:Int, x:Int, y:Int)
	{
		if(button == 0)
		{
			for(i in picks)
			{
				if(!picked && x > i.activeSprite.x && x < i.activeSprite.x + i.activeSprite.width
				&& y > i.activeSprite.y && y < i.activeSprite.y + i.activeSprite.height)
				{
					if(activePick == null)
					{
						activePick = i;
						i.turn();
					}
					else
					{
						if(activePick.value == i.value)
						{
							i.turn();
							activePick = null;
							
							var win = true;
							for(i in picks)
							{
								if(i.active == false)
								{
									win = false;
									break;
								}								
							}
							if(win)
							{
								winText = "You Win";
							}
						}
						else
						{
							i.turn();
							turnTimer = new Timer(500);
							picked = true;
							turnTimer.run = function() {
								activePick.turn();
								i.turn();
								activePick = null;
								picked = false;
								turnTimer.stop();
								turnTimer = null;
							}
						}
					}
					break;
				}
			}
		}
		if(button == 1)
		{

		}
	}

	public function onMouseUp(button:Int, x:Int, y:Int)
	{
		if(button == 0)
		{

		}
		if(button == 1)
		{

		}
	}

	public function onMouseMove(x:Int, y:Int, cx:Int, cy:Int)
	{
		if(x > 0)
		{

		}
		if(y > 0)
		{

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
