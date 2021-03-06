package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import kha2d.Scene;
import kha2d.Sprite;
import kha.input.KeyCode;
import kha.input.Keyboard;
import kha.audio1.Audio;

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
	var numNodesWidth:Int = 9;
	var numNodesHeight:Int = 19;
	var nodeSpriteWidth:Int = 32;
	var nodeSpriteHeight:Int = 32;
	var score = 0;
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
		Audio.play(Assets.sounds.tetris,true);
		
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
		Scheduler.addTimeTask(turn, 0, 1/2);
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
			Audio.play(Assets.sounds.MinorExplosion,false).volume = .5;
			evaluate();
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


	function onKeyDown(key:Int)
	{
		switch(key)
		{
			case KeyCode.A | KeyCode.Left: 
				move(true);
			case KeyCode.D | KeyCode.Right: 
				move(false);
			case KeyCode.Up | KeyCode.W: 
				rotate();
			case KeyCode.S | KeyCode.Down: 
				turn();
		}
	}


	function isPointTaken(p:Point):Bool
	{
		var result = false;
		for(i in takenNodePos)
		{
			if(p.x == i.x && p.y == i.y)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	function move(goingLeft:Bool)
	{
		var priorNodePos = [];
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
			}
			else
			{
				activeNodePos[i].x++;
			}
		}
		if(brokeBoundOrOverlap())
		{
			activeNodePos = priorNodePos;
		}
		for(i in 0...activeNodePos.length)
		{
			nodes[activeNodePos[i].x][activeNodePos[i].y].setImage(Assets.images.green);
		}
	}




	function rotate()
	{
		priorRotateNodePos = [];
		var originMinX = numNodesWidth;
		var originMinY = numNodesHeight;
		var farX = 0;
		//setup necessary vars
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

		moveTopLeft(originMinX, originMinY);

		rotateActShape();

		adjust();

		moveBack(farX, originMinX, originMinY);
		
		//'Redraw'
		for(i in priorRotateNodePos)
		{
			nodes[i.x][i.y].setImage(Assets.images.black);
		}
	
		if(brokeBoundOrOverlap())
		{
			activeNodePos = priorRotateNodePos;
		}
		for(i in activeNodePos)
		{
			nodes[i.x][i.y].setImage(Assets.images.green);
		}
	}

	function rotateActShape()
	{
		for(i in activeNodePos)
		{
			var oldP = i.clone();
			i.x = oldP.y * -1;
			i.y = oldP.x;
		}
	}

	function moveBack(farX:Int, originMinX:Int, originMinY:Int)
	{
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
	}

	function adjust()
	{
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
	}

	function moveTopLeft(originMinX:Int, originMinY:Int)
	{
		for(i in activeNodePos)
		{
			i.x -= originMinX;			
			i.y -= originMinY;
		}
	}

	function brokeBoundOrOverlap():Bool
	{
		var result = false;
		for(i in activeNodePos)
		{
			if(i.x >= numNodesWidth || i.x < 0 || isPointTaken(i))
			{
				result = true;
				break;
			}
		}
		return result;

	}

	function evaluate()
	{
		for(i in 0...activeNodePos.length)
		{
			takenNodePos.push(activeNodePos[i]);
		}
		var rowsToExplode = determinRowsToExplode();
		score += rowsToExplode.length * 100;
		removeNodes(rowsToExplode);

		shiftPieces(rowsToExplode);		

		redoBoard();

		createNewShape();
	}

	function redoBoard()
	{
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
	}

	function removeNodes(rowsToExplode:Array<Int>)
	{
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
		if(removableNodes.length > 0)
		{
			Audio.play(Assets.sounds.Explosion,false);
		}

		for(i in removableNodes)
		{
			takenNodePos.splice(takenNodePos.indexOf(i),1);
		}
	}

	function shiftPieces(rowsToExplode:Array<Int>)
	{
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
	}

	function determinRowsToExplode():Array<Int>
	{
		var result = [];
		for(i in activeNodePos)
		{
			var count = 0;
			if(result.indexOf(i.y) == -1)
			{
				for(j in takenNodePos)
				{
					if(j.y == i.y)
					{
						count++;
						if(count == numNodesWidth)
						{
							result.push(i.y);
						}
					}
				}
			}
		}
		return result;
	}

	function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);		
		graphics.font = Assets.fonts.OpenSans;
		graphics.fontSize = 64;
		graphics.drawString(score+"", 290, 32);
		graphics.fontSize = 32;
		graphics.drawString("Original Concept", 290, 96);
		graphics.drawString("by Alexey Pajinov", 290, 124);
		graphics.drawString("Original Music", 290, 160);
		graphics.drawString("by Hirokazu Tanaka", 290, 192);
		graphics.end();
	}
}
