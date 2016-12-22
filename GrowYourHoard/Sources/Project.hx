package;

import kha.Framebuffer;
import kha2d.Scene;
import states.IState;
import states.MenuState;
import states.HoardState;
import kha.Assets;
import util.Text;
import Reg;
import verlet.Verlet;
import verlet.Renderer;

class Project 
{
	
	public static var the(get, null):Project;

	var activeState:IState;
	var world:Verlet = new Verlet(Reg.gameWidth,Reg.gameHeight);
	var images:Dynamic;
		// Render Verlet world
	var verletRenderer:Renderer;

	private function new() 
	{
		Reg.reset();
		activeState = new HoardState();
		activeState.init();
		util.ButtonManager.the;
		verletRenderer = Renderer.Instance;
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
		activeState.update();
		world.update(10);
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
		//verletRenderer.renderAll(framebuffer.g2);
		framebuffer.g2.end();
	}

	public function changeState(s:IState)
	{
		if(activeState != null)
		{
			activeState.kill();
		}
		activeState = s;
		activeState.init();
	}
}
