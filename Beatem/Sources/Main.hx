package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.start({
			title:"Beatem",
			width:1024,
			height:320
		},
		function(_){
			Assets.loadEverything(function(){new Project();});
		});
	}
}
