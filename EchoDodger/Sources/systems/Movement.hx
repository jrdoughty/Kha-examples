package systems;

import echoes.System;
import components.Position;
import components.Velocity;

class Movement extends  System
{
    var w:Float;
    var h:Float;


    public function new(w:Float, h:Float) {
        this.w = w;
        this.h = h;
    }


    @u inline function move(dt:Float, pos:Position, vel:Velocity) {
        var dx = vel.x * dt;
        var dy = vel.y * dt;

        pos.x += dx;
        pos.y += dy;

        
    }

}