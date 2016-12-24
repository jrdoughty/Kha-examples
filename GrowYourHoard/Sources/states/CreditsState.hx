package states;

import util.Text;
import util.Button;
import kha.Assets;
import util.Button;
import kha2d.Scene;
import kha2d.Sprite;
/**
 * ...
 * @author John Doughty
 */
class CreditsState extends BaseState
{
	
	
	public function new()
	{
	}

	override public function init():Void 
	{
		Scene.the.addOther(new Sprite(Assets.images.menubackground));
		new Text("GROW YOUR", 70, 0, 20);
		new Text("HOARD", 90, 25, 20);
		new Text("Nicholas Cash Code",55, 55, 16);
		new Text("John Doughty Code and Art", 30, 80, 16);
		if (Reg.counters["goblins_harmed"] + Reg.counters["greedy_goblins_harmed"] +Reg.counters["ogres_harmed"] > 0)
		{
			new Text(Reg.counters["goblins_harmed"] + " Goblins " + Reg.counters["greedy_goblins_harmed"] + " Greedy Goblins",10, 108, 16);
			new Text("and " +Reg.counters["ogres_harmed"]+" Ogres were harmed", 30, 133, 16);
			new Text("growing your hoard", 60, 158, 16);
			
		}
		new util.Button(75, 180, 150, 50, new Sprite(Assets.images.button), "Menu", menu, 27);
	}

	public function menu(?b:Int,?x:Int,?y:Int)
	{
		Project.the.changeState(new MenuState());
	}
}