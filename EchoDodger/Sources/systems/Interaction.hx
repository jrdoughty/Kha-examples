package systems;

import echoes.System;
import echoes.View;
import components.*;

class Interaction extends System
{
    var enemies:View<Enemy, Position, Scale>;
    @u inline function interaction(player:Player, pos:Position) {
        // micro optimizaion to not test each entity twice
        var h1 = enemies.entities.head;
        while (h1 != null) {

            var entity1 = h1.value;
            var pos1 = entity1.get(Position);

            
            if (test(pos1, pos, 32.0*entity1.get(Scale).value)) {
                pos1.y = 0;
            }
            

            h1 = h1.next;
        }
    }


    function test(pos1:Position, pos2:Position, radius:Float) {
        var dx = pos2.x - pos1.x;
        var dy = pos2.y - pos1.y;
        return dx * dx + dy * dy < radius * radius;
    }
}