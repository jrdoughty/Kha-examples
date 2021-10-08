package systems;

import echoes.System;
import components.*;

class Render extends System
{

    public function new(w:Int, h:Int)
    {
		//System.notifyOnRender(updateMovedSprite);
    }


    @ad inline function onAddPosSprite(pos:Position) 
    {
        //tiles[Std.int(pos.y)][Std.int(pos.x)].appendChild(spr); 
    }
    @rm inline function onRemovePosSprite(pos:Position) 
    {
        //spr.remove();
    }

    @u inline function updateMovedSprite(pos:Position) 
    {
		//Scene.the.render(graphics);
        //tiles[Std.int(pos.y)][Std.int(pos.x)].appendChild(spr);
        
    }
}