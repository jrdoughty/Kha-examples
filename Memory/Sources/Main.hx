package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 384, height: 384}, function () {
			Assets.loadEverything(function(){new Project();});
		});
	}
}
