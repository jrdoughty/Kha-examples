package;

import kha.System;

class Main {
	public static function main() {
		System.init({title: "Project", width: 320, height: 240}, function () {
			new Project();
		});
	}
}
