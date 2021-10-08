package;

import kha.System;
import kha.Assets;
import kha.Scheduler;
import echoes.Workflow;
import components.*;
import systems.*;

class Main 
{
	public static var WIDTH = 900;
	public static var HEIGHT = 900;
	public static function main() {
		System.start({
			title:"Dodger",
			width:WIDTH,
			height:HEIGHT
		},
		function(_){
			Assets.loadEverything(function()
			{	
				new Project();
				Workflow.addSystem(new Movement(WIDTH, HEIGHT));
				Workflow.addSystem(new Controls());
				Workflow.addSystem(new Interaction());
				Workflow.addSystem(new Bounds(WIDTH, HEIGHT));
				Workflow.addSystem(new Animation());
			});
		});
	}
}
