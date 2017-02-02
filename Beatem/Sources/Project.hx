package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;
import sdg.Engine;
import sdg.manager.Keyboard;
import sdg.manager.GamePadMan;
import sdg.Sdg;
import sdg.atlas.Atlas;
import sdg.collision.Hitbox;
import screens.PlayScreen;
import sdg.manager.Manager.*;

class Project {
	public function new() {
		Assets.loadEverything(assetsLoaded);
	}

	function assetsLoaded()
	{
		var engine = new Engine(1024, 320);
		engine.enable(KEYBOARD | MOUSE | GAMEPAD);

		//Atlas.loadAtlasShoebox(Assets.images.textures, Assets.blobs.textures_xml);

		// Initializes the collision system
		Hitbox.init();

		Sdg.addScreen('Play', new PlayScreen(), true);

		System.notifyOnRender(engine.render);
		Scheduler.addTimeTask(engine.update, 0, 1 / 60);
	}
}
