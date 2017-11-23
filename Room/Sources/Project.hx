package;

import kha.Framebuffer;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Assets;
import util.Text;
import kha.input.Mouse;
import Data;
import kha2d.Animation;
import util.Button;

class Project {
	var activeLevel:Int = 0;
	var chatName:String = "main";
	var pointInConvArray:Int = 0;
	var pointInTextArray:Int = 0;
	var data = Data.the;
	var chats:Map<String,Dynamic>;
	var t:Text;
	var diagnosis:Text = new Text("test",0,360,40);
	var buttonsActive:Bool = false;
	var but = Button.buttons;
	public function new() {
		var background = new Sprite(Assets.images.background);
		background.x = 0;
		background.y = 0;
		Scene.the.addOther(background);
		t = new Text("",0,0,30);
		Mouse.get().notify(down, up, move, scroll);
		startLevel();
		util.ButtonManager.the;
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
					trace("dialog");
					processDialog();
				}
				else if (chats.get(chatName)[pointInConvArray].type == "reaction")
				{
					trace("reaction");
					processReaction();
				}
				else if (chats.get(chatName)[pointInConvArray].type == "choice")
				{
					trace("choice");
					processChoice();
				}
				checkForEndLevel();
			}
		}
		else
		{
			trace("chat name is " + chatName +" and buttons are considered "+(buttonsActive?"active":"deactivated"));
		}
	}

	public function processDialog()
	{
		if(chats.get(chatName)[pointInConvArray].texts.length > pointInTextArray)
		{
			t.content = chats.get(chatName)[pointInConvArray].char +": "+ chats.get(chatName)[pointInConvArray].texts[pointInTextArray].text;
			if(chats.get(chatName)[pointInConvArray].texts[pointInTextArray].chat != null)
			{
				chatName = chats.get(chatName)[pointInConvArray].texts[pointInTextArray].chat;
				pointInTextArray = 0;
				pointInConvArray = 0;
			}
			else
			{
				pointInTextArray++;
				if(pointInTextArray == chats.get(chatName)[pointInConvArray].texts.length)
				{
					pointInConvArray++;
					pointInTextArray = 0;
				}
			}
		}
	}

	public function processReaction()
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

	public function processChoice()
	{
		var bs:Array<Button> = [];
		t.content = "";
		for(i in 0...chats.get(chatName)[pointInConvArray].texts.length)
		{
			buttonsActive = true;
			bs.push(new Button(75,100+i*75, 540, 60,new Sprite(Assets.images.button),chats.get(chatName)[pointInConvArray].texts[i].text,function(l:Int,j:Int,k:Int)
				{
					chatName = chats.get(chatName)[pointInConvArray].texts[i].chat;
					buttonsActive = false;
					Button.clear();
					pointInConvArray = 0;
					pointInTextArray = 0;
					checkForEndLevel();
					down(l,j,k);
				},16));
		}
	}

	public function checkForEndLevel()
	{
		if(chatName == "endlevel")
		{

			for(i in data.levels[activeLevel].sprites)
			{
				Scene.the.removeOther(SpriteMap.the.get(i.idString));
			}
			pointInConvArray = 0;
			pointInTextArray = 0;
			activeLevel++;
			chatName = "main";
			trace("level is now "+activeLevel);
			startLevel();
		}
	}

	private function startLevel()
	{
		diagnosis.content = data.levels[activeLevel].days+" days since Dimentia diagnosis";
		for(i in data.levels[activeLevel].sprites)
		{
			var s = SpriteMap.the.get(i.idString);
			s.x = i.x;
			s.y = i.y;
			s.setAnimation(new Animation([i.frame],0));
			Scene.the.addOther(s);
		}
	}

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
