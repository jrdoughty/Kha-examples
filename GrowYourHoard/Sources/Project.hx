package;

import kha.Framebuffer;
import kha2d.Scene;
import states.IState;
import states.MenuState;
import kha.Assets;
import util.Text;

class Project 
{
	
	public static var the(get, null):Project;

	var activeState:IState;
	var images:Dynamic;

	private function new() 
	{
		activeState = new MenuState();
		activeState.init();
		util.ButtonManager.the;
	}

	private static function get_the():Project
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

	public function changeState(s:IState)
	{
		activeState = s;
		activeState.init();
	}
}
