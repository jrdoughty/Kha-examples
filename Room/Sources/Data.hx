import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;
class Data {
	public static var the(get, null):Data;
	public var levels:Array<LevelData> = [];

	private static function get_the():Data
	{
		if(the == null)
		{
			the = new Data();
		}
		return the;
	}

	private function new()
	{
		var data = haxe.Json.parse(Assets.blobs.data_json.toString());
		for(i in 0...data.levels.length)
		{
			var lvlArr:Array<Dynamic> = cast data.levels;
			var lvlData = lvlArr[i];
			levels.push(new LevelData());
			levels[i].id = lvlData.id;
			levels[i].days = lvlData.days;
			levels[i].chats = new Map<String, Array<Dialog>>();
			for(j in Reflect.fields(lvlData.chats))
			{
				levels[i].chats.set(j, Reflect.getProperty(lvlData.chats, j));
			}

			levels[i].sprites = lvlData.sprites;
		}
	}
}
class LevelData 
{
	public var chats:Map<String, Array<Dialog>>;
	public var id:Int;
	public var sprites:Array<SpriteData> = [];
	public var days:Int;
	public function new(){};
}
typedef Dialog = {
	var type:String;
	var char:String;
	var texts:Array<Chat>;
}

typedef Chat = {
	var text:String;
	var chat:String;
}

typedef SpriteData = {
	var idString:String;
	var x:Float;
	var y:Float;
	var frame:Int;
}

class SpriteMap
{
	public static var the(get, null):SpriteMap;
	var spriteMap = new Map<String, Sprite>();
	
	private static function get_the():SpriteMap
	{
		if(the == null)
		{
			the = new SpriteMap();
		}
		return the;
	}
	private function new()
	{
		spriteMap.set("John",new Sprite(Assets.images.john,28));
		spriteMap.set("Grandma",new Sprite(Assets.images.grandma,33));
		spriteMap.set("Mom",new Sprite(Assets.images.mom,33));
		spriteMap.set("Vincent",new Sprite(Assets.images.vincent,28));
	}
	public function get(s:String):Sprite
	{
		return spriteMap.get(s);
	}
}