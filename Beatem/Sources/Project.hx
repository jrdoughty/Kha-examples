package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import sdg.Engine;
import sdg.manager.Keyboard;
import sdg.manager.GamePads;
import sdg.Sdg;
import sdg.atlas.Atlas;
import sdg.collision.Hitbox;
import screens.MenuScreen;

class Project {
	public function new() {
		Assets.loadEverything(assetsLoaded);
	}

	function assetsLoaded()
	{
		var engine = new Engine(320, 240);
		engine.addManager(new Keyboard());
		engine.addManager(new GamePads());

		//Atlas.loadAtlasShoebox(Assets.images.textures, Assets.blobs.textures_xml);

		// Initializes the collision system
		Hitbox.init();

		Sdg.addScreen('Menu', new MenuScreen(), true);

		System.notifyOnRender(engine.render);
		Scheduler.addTimeTask(engine.update, 0, 1 / 60);
	}
}
