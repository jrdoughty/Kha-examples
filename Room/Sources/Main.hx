package;

import kha.System;
import kha.Assets;
import kha.Scheduler;

class Main {
	public static function main() {
		System.init({title: "Project", width: 1024, height: 768}, function () {
			Assets.loadEverything(function(){
				var p = new Project();
				System.notifyOnRender(p.render);
				Scheduler.addTimeTask(p.update, 0, 1 / 60);
			});
		});
	}
}
