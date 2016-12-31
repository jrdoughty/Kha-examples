package screens;

import sdg.Screen;
import actors.Player;
import kha.Assets;

class MenuScreen extends Screen
{
	public function new()
	{
		super();
		add(new Player(0,0,Assets.images.knight,32,32));
	}
}