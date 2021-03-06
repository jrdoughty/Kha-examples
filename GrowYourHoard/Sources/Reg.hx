package;

class Reg
{
	public static var score:Int;
	public static var level:Int;

	public static var counters:Map<String,Int> = new Map<String,Int>();
	public static var upgrades:Map<String,Map<String,Int>> = new Map<String,Map<String,Int>>();
	
	public static var gameWidth = 320; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	public static var gameHeight = 240; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	
	public static var inLevel:Bool = false;

	public static function reset():Void
	{
		Reg.score = 0;
		Reg.level = 0;
		Reg.counters = [
			"goblins_launched"        => 0,
			"greedy_goblins_launched" => 0,
			"ogres_launched"          => 0,
			"goblins_harmed"        => 0,
			"greedy_goblins_harmed" => 0,
			"ogres_harmed"          => 0,
			"arrows_launched"         => 0,
			"axes_launched"           => 0,
			"axes_blocked"            => 0,
			"arrows_blocked"          => 0
		];

		Reg.upgrades = [
			"goblin" => [
				"cost"   => 0,
				"number" => 999999999
			],
			"greedy_goblin" => [
				"cost"   => 1,
				"number" => 10
			],
			"ogre" => [
				"cost"   => 1,
				"number" => 10
			],
			"large_shield" => [
				"cost"   => 3,
				"number" => 10
			]
		];
	}

}