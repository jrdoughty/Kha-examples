package systems;

import components.*;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;

class Animation extends echoes.System
{
    public static function render(g: Graphics, ac:AnimComp, ic:ImageComp, wh:WH, pos:Position, s:Scale): Void {
		if (ic.value != null){ //&& visible) {
			//g.color = Color.White;
			//if (angle != 0) g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(x + originX, y + originY)).multmat(FastMatrix3.rotation(angle)).multmat(FastMatrix3.translation(-x - originX, -y - originY)));
			g.drawScaledSubImage(ic.value, Std.int(ac.indices[ac.index] * wh.w) % ic.value.width, 
            Math.floor(ac.indices[ac.index] * wh.w / ic.value.width) * wh.h, 
            wh.w, 
            wh.h, 
            Math.round(pos.x), 
            Math.round(pos.y), 
            wh.w * s.value, 
            wh.h * s.value);
			//if (angle != 0) g.popTransformation();
		
        }
		#if debug_collisions
			g.color = Color.fromBytes(255, 0, 0);
			g.drawRect(x - collider.x * scaleX, y - collider.y * scaleY, width, height);
			g.color = Color.fromBytes(0, 255, 0);
			g.drawRect(tempcollider.x, tempcollider.y, tempcollider.width, tempcollider.height);
		#end
	}
	
	
	
	@u public inline function update(ac:AnimComp){
		ac.count++;
		if (ac.count % ac.speeddiv == 0) {
			++ac.index;
			if (ac.index >= ac.indices.length) {
				ac.index = 0;
			}
		}
	}
}




