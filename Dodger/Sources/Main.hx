package;

import kha.System;
import kha.Assets;
import kha.Scheduler;
class Main {
	public static function main() {
		System.init({title: "Project", width: 640, height: 400}, function () {
			Assets.loadEverything(assetsLoaded);
			});
	}

	static private function assetsLoaded()
	{
		var Project = new Project();
	}
}
