package states;
import util.Button;
import kha2d.Scene;
import util.Text;

class BaseState implements IState
{

	public function init():Void
	{

	}
	public function update():Void
	{

	}

	public function kill():Void
	{
		Button.clear();
		Scene.the.clear();
		Text.clear();
	}
}