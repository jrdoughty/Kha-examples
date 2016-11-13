package;

import kha.System;
import kha.Scheduler;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: Reg.gameWidth, height: Reg.gameHeight}, function () {
			Assets.loadEverything( function(){
				var project = Project.the;
				System.notifyOnRender(project.render);
				Scheduler.addTimeTask(project.update, 0, 1 / 60);
			});
		});
	}
}
