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
		var spriteMap = new Map<String, Sprite>();
		spriteMap.set("John",new Sprite(Assets.images.john,28));
		for(i in 0...data.levels.length)
		{
			var lvlArr:Array<Dynamic> = cast data.levels;
			var lvlData = lvlArr[i];
			levels.push(new LevelData());
			levels[i].id = lvlData.id;
			levels[i].chats = new Map<String, Array<Dialog>>();
			for(j in Reflect.fields(lvlData.chats))
			{
				levels[i].chats.set(j, Reflect.getProperty(lvlData.chats, j));
			}
			var count = 0;
			var sprites:Array<Dynamic> =  cast lvlData.sprites;
			for(j in sprites)
			{
				levels[i].sprites.push(spriteMap.get(j.idString));
				levels[i].sprites[count].x = j.x;
				levels[i].sprites[count].y = j.y;
				count++;
			}
		}
	}
}
class LevelData 
{
	public var chats:Map<String, Array<Dialog>>;
	public var id:Int;
	public var sprites:Array<Sprite> = [];
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