package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 512, height: 512}, function () {
			Assets.loadEverything(function(){new Project();});
		});
	}
}
