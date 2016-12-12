package;

import kha.Framebuffer;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Assets;
import util.Text;
import kha.input.Mouse;
import Data;
import util.Button;

class Project {
	var activeLevel:Int = 0;
	var chatName:String = "main";
	var pointInConvArray:Int = 0;
	var pointInTextArray:Int = 0;
	var data = Data.the;
	var chats:Dynamic;
	var t:Text;
	var buttonsActive:Bool = false;
	public function new() {
		var background = new Sprite(Assets.images.background);
		background.x = 0;
		background.y = 0;
		Scene.the.addOther(background);
		t = new Text("");
		Mouse.get().notify(down, up, move, scroll);
		util.ButtonManager.the;
		for(i in data.levels[activeLevel].sprites)
		{
			Scene.the.addOther(i);
		}
	}

	public function down(mButton:Int, x:Int, y:Int)
	{
		chats = data.levels[activeLevel].chats;
		if(chats.exists(chatName) && !buttonsActive)
		{
			if(chats.get(chatName).length > pointInConvArray)
			{
				if(chats.get(chatName)[pointInConvArray].type == "dialog")
				{
					if(chats.get(chatName)[pointInConvArray].texts.length > pointInTextArray)
					{
						t.content = chats.get(chatName)[pointInConvArray].char +": "+ chats.get(chatName)[pointInConvArray].texts[pointInTextArray].text;
						pointInTextArray++;
						if(pointInTextArray == chats.get(chatName)[pointInConvArray].texts.length)
						{
							pointInConvArray++;
							pointInTextArray = 0;
						}
					}
				}
				else if (chats.get(chatName)[pointInConvArray].type == "reaction")
				{
					pointInTextArray = Math.floor(Math.random() * chats.get(chatName)[pointInConvArray].texts.length);
					t.content = chats.get(chatName)[pointInConvArray].char +": "+ chats.get(chatName)[pointInConvArray].texts[pointInTextArray].text;
					if(chats.get(chatName)[pointInConvArray].texts[pointInTextArray].chat != null)
					{
						chatName = chats.get(chatName)[pointInConvArray].texts[pointInTextArray].chat;
						pointInConvArray = 0;
						pointInTextArray = 0;
					}
				}
				else if (chats.get(chatName)[pointInConvArray].type == "choice")
				{
					var bs:Array<Button> = [];
					for(i in 0...chats.get(chatName)[pointInConvArray].texts.length)
					{
						buttonsActive = true;
						bs.push(new Button(75,100+i*50, 450, 45,new Sprite(Assets.images.button),chats.get(chatName)[pointInConvArray].texts[i].text,function(l:Int,j:Int,k:Int)
							{
								trace(i);
								chatName = chats.get(chatName)[pointInConvArray].texts[i].chat;
								trace(chatName);
								buttonsActive = false;
								Button.clear();
								down(l,j,k);
							},16));
					}
				}
			}
			else if(!buttonsActive)
			{

				for(i in data.levels[activeLevel].sprites)
				{
					Scene.the.removeOther(i);
				}
				pointInConvArray = 0;
				pointInTextArray = 0;
				activeLevel++;
				chatName = "main";
				trace("level is now "+activeLevel);
				for(i in data.levels[activeLevel].sprites)
				{
					Scene.the.addOther(i);
				}
			}
		}
		
	}

	public function processDialog()
	{}

	public function up(mButton:Int, x:Int, y:Int)
	{
	}	
	public function move(x:Int,y:Int,cx:Int,cy:Int)
	{

	}
	public function scroll(scroll:Int)
	{

	}
	public function update(): Void {
		Scene.the.update();
	}

	public function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;

		graphics.begin();
		Scene.the.render(graphics);	
		for(i in Text.texts)
		{
			i.render(graphics);
		}
		graphics.end();
	}
}
