package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Key;
import kha.input.Keyboard;

class Point {
	public var x:Int;
	public var y:Int;
	public function new(x:Int, y:Int) {
		this.x = x;
		this.y = y;
	}
	public function clone()
	{
		return new Point(x,y);
	}
}

class Project {
	var nodes: Array<Array<Sprite>> = [[]];
	var activeNodePos: Array<Point> = [];
	var takenNodePos: Array<Point> = [];
	var priorRotateNodePos: Array<Point>;
	var numNodesWidth:Int = 5;
	var numNodesHeight:Int = 10;
	var nodeSpriteWidth:Int = 32;
	var nodeSpriteHeight:Int = 32;
	var score = 1;
	var shapes: Array<Array<Point>> = [
		[new Point(0,0), new Point(1,0), new Point(1,1), new Point(0,1)],//sq
		[new Point(0,0), new Point(1,0), new Point(2,0), new Point(3,0)],//stick
		[new Point(0,0), new Point(1,0), new Point(1,1), new Point(2,1)],//z
		[new Point(0,1), new Point(1,1), new Point(1,0), new Point(2,0)],//s
		[new Point(0,0), new Point(1,0), new Point(0,1), new Point(0,2)],//J
		[new Point(0,0), new Point(1,0), new Point(1,1), new Point(1,2)],//L
		[new Point(0,0), new Point(0,1), new Point(0,2), new Point(1,1)]//T
	];

	public function new() {
		var i;
		var j;
		
		for(i in 0...numNodesWidth)
		{
			nodes.push([]);
			for(j in 0...numNodesHeight)
			{
				nodes[i].push(new Sprite(Assets.images.black, nodeSpriteWidth, nodeSpriteHeight));
				nodes[i][j].x = i * nodeSpriteWidth;
				nodes[i][j].y = j * nodeSpriteHeight;
				Scene.the.addOther(nodes[i][j]);
			}
		}

		createNewShape();

		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		Scheduler.addTimeTask(turn, 0, 1);
		Keyboard.get().notify(onKeyDown, null);
	}

	function createNewShape()
	{
		var randomShape = Math.floor(Math.random() * shapes.length);
		activeNodePos = [];
		for(i in 0...shapes[randomShape].length)
		{
			activeNodePos.push(new Point(shapes[randomShape][i].x,shapes[randomShape][i].y));
			nodes[shapes[randomShape][i].x][shapes[randomShape][i].y].setImage(Assets.images.green);
		}
	}

	function update(): Void {
		
	}

	function turn()
	{
		var stop = false;
		for(i in 0...activeNodePos.length)
		{
			if(activeNodePos[i].y + 1 >= numNodesHeight)
			{
				stop = true;
				break;
			}
			for(j in takenNodePos)//UGLY LOOPING!!!
			{
				if(activeNodePos[i].x == j.x && activeNodePos[i].y + 1 == j.y)
				{
					stop = true;
				}
			}
		}
		if(stop)
		{
			for(i in 0...activeNodePos.length)
			{
				takenNodePos.push(activeNodePos[i]);
			}
			var count = 0;
			var rowsToExplode = [];
			for(i in activeNodePos)
			{
				count = 0;
				if(rowsToExplode.indexOf(i.y) == -1)
				{
					for(j in takenNodePos)
					{
						if(j.y == i.y)
						{
							count++;
							if(count == numNodesWidth)
							{
								rowsToExplode.push(i.y);
							}
						}
					}
				}
			}
			var removableNodes = [];
			for(i in rowsToExplode)
			{
				for(j in takenNodePos)
				{
					if(j.y == i)
					{
						removableNodes.push(j);
					}
				}
			}
			for(i in removableNodes)
			{
				takenNodePos.splice(takenNodePos.indexOf(i),1);
			}
			for(i in takenNodePos)
			{
				var toMove = 0;
				for(j in rowsToExplode)
				{
					if(i.y < j)
					{
						toMove++;
					}
				}
				i.y += toMove;
			}
			for(i in nodes)
			{
				for(j in i)
				{
					j.setImage(Assets.images.black);
				}
			}
			for(i in takenNodePos)
			{
				nodes[i.x][i.y].setImage(Assets.images.green);
			}
			createNewShape();
		}
		else
		{
			for(i in 0...activeNodePos.length)
			{
				nodes[activeNodePos[i].x][activeNodePos[i].y].setImage(Assets.images.black);
				activeNodePos[i].y++;
			}
		}
		for(i in 0...activeNodePos.length)
		{
			nodes[activeNodePos[i].x][activeNodePos[i].y].setImage(Assets.images.green);
		}
	}


	function onKeyDown(key:Key, char:String)
	{
		switch(key)
		{
			case LEFT:
				move(true);
			case RIGHT:
				move(false);
			case DOWN:
				turn();
			case UP:
				rotate();
			default: switch(char)
			{
				case " ":
					rotate();
				case "w":
					rotate();
				case "a":
					move(true);
				case "d":
					move(false);
				case "s":
					turn();
			}
		}
	}


	function move(goingLeft:Bool)
	{
		var priorNodePos = [];
		var breakBounds:Bool = false;
		//Movetopleft
		for(i in activeNodePos)
		{
			priorNodePos.push(i.clone());
		}
		for(i in 0...activeNodePos.length)
		{
			nodes[activeNodePos[i].x][activeNodePos[i].y].setImage(Assets.images.black);
			if(goingLeft)
			{
				activeNodePos[i].x--;
				if(activeNodePos[i].x < 0)
				{
					breakBounds = true;
					break;
				}
			}
			else
			{
				activeNodePos[i].x++;
				if(activeNodePos[i].x >= numNodesWidth)
				{
					breakBounds = true;
					break;
				}
			}
		}
		if(breakBounds)
		{
			activeNodePos = priorNodePos;
		}
		for(i in 0...activeNodePos.length)
		{
			nodes[activeNodePos[i].x][activeNodePos[i].y].setImage(Assets.images.green);
		}
	}

	function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);
		graphics.end();
	}




	function rotate()
	{
		priorRotateNodePos = [];
		var originMinX = numNodesWidth;
		var originMinY = numNodesHeight;
		var farX = 0;
		//Movetopleft
		for(i in activeNodePos)
		{
			priorRotateNodePos.push(i.clone());
			if(i.x < originMinX)
			{
				originMinX = i.x;
			}
			if(i.x > farX)
			{
				farX = i.x;
			}
			if(i.y < originMinY)
			{
				originMinY = i.y;
			}
		}
		for(i in activeNodePos)
		{
			i.x -= originMinX;			
			i.y -= originMinY;
		}

		//rotate
		for(i in activeNodePos)
		{
			var oldP = i.clone();
			i.x = oldP.y * -1;
			i.y = oldP.x;
		}

		//adjustpos
		var adjustX = 0;
		var adjustY = 0;
		for(i in activeNodePos)
		{
			if(i.x < adjustX)
			{
				adjustX = i.x;
			}
			if(i.y < adjustY)
			{
				adjustY = i.y;
			}
		}

		for(i in activeNodePos)
		{

			i.x -= adjustX;			
			i.y -= adjustY;
		}

		//Moveback
		for(i in activeNodePos)
		{
			i.x += originMinX;			
			i.y += originMinY;
		}
		
		var lowX = numNodesWidth;
		var highX = 0;
		for(i in activeNodePos)
		{
			if(i.x < lowX)
			{
				lowX = i.x;
			}
			if(i.x > highX)
			{
				highX = i.x;
			}
		}


		//Moveback
		for(i in activeNodePos)
		{
			if(highX - lowX > farX - originMinX)
			{
				i.x--;
			}
			else if(highX - lowX < farX - originMinX)
			{
				i.x++;
			}
		}


		//'Redraw'
		for(i in priorRotateNodePos)
		{
			nodes[i.x][i.y].setImage(Assets.images.black);
		}
		var brokeBound:Bool = false;
		for(i in activeNodePos)
		{
			if(i.x >= numNodesWidth || i.x < 0)
			{
				brokeBound = true;
			}
		}
		if(brokeBound)
		{
			activeNodePos = priorRotateNodePos;
		}
		for(i in activeNodePos)
		{
			nodes[i.x][i.y].setImage(Assets.images.green);
		}
	}
}
