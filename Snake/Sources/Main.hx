package;

import kha.System;
import kha.Assets;

class Main {	
	public static function main() {	
		System.start({
			title:"Snake",
			width:512,
			height:512
		},
		function(_){
			Assets.loadEverything(function(){new Project();});
		});
	}
}
