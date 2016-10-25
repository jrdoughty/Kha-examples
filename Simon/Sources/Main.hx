package;

import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 128, height: 128}, function () {
			#if js
			var canvas = cast(js.Browser.document.getElementById('khanvas'), js.html.CanvasElement);
			canvas.width = 128;
			canvas.height = 128;      
			#end
			Assets.loadEverything(function(){new Project();});
		});
	}
}
