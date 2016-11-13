package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha2d.Scene;
import states.IState;
import kha2d.Sprite;
import states.MenuState;
import kha.Assets;
import util.Text;

class Project {
	
	public static var the(get, null):Project;

	var activeState:IState;
	var images:Dynamic;

	private function new() 
	{
		//Scene.the.addHero(new Sprite(Assets.images.background));
		activeState = new MenuState();
	}

	public static function get_the():Project
	{
		if(the == null)
		{
			the = new Project();
		}
		return the;
	}

	public function update(): Void 
	{
		Scene.the.update();
	}

	public function render(framebuffer: Framebuffer): Void 
	{
		var images = Assets.images;
		framebuffer.g2.begin();
		Scene.the.render(framebuffer.g2);
		for(i in Text.texts)
		{
			i.render(framebuffer.g2);
		}
		framebuffer.g2.end();
	}
}
