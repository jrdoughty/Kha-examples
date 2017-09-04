import kha2d.Sprite;
import kha2d.Scene;
import kha.Image;
import kha.Sound;

typedef PickData= {sound:Sound, image:Image}

class Pick extends Sprite
{
	public var sound:Sound;
	public function new(pd: PickData) 
	{
		super(pd.image,64,64);//, Std.int(Scene.the.getWidth()/4),Std.int(Scene.the.getHeight()/4), 1);
		sound = pd.sound;
	}
}