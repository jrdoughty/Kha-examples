package components;

import echoes.Entity;

class Tween {

    public var time:Float;
    public var timeout:Float;
    public var onUpdate:Float->Void;
    public var onComplete:Void->Void;

    public function new(timeout:Float, ?onUpdate:Float->Void, ?onComplete:Void->Void) {
        this.time = .0;
        this.timeout = timeout;
        this.onUpdate = onUpdate;
        this.onComplete = onComplete;
    }

}
