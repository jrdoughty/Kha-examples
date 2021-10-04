package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.start({
			title:"Memory",
			width:256,
			height:256
		},
		function(_){
			Assets.loadEverything(function(){new Project();});
		});
	}
}
