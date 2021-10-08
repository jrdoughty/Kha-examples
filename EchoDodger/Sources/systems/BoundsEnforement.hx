package systems;

import echoes.System;
import components.Position;

class Bounds extends System
{
    var w:Float;
    var h:Float;


    public function new(w:Float, h:Float) {
        this.w = w;
        this.h = h;
    }


    @u inline function move(pos:Position) {
        if(pos.y > h)
        {
            pos.y = 0;
        }

        
    }

}