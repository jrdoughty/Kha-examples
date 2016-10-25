package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 1024, height: 768}, function () {
			Assets.loadEverything(function(){new Project();});
		});
	}
}
