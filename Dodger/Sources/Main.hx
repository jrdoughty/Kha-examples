package;

import kha.System;
import kha.Assets;
import kha.Scheduler;
class Main {
	public static function main() {
		System.start({
			title:"Dodger",
			width:900,
			height:900
		},
		function(_){
			Assets.loadEverything(function(){new Project();});
		});
	}
}
