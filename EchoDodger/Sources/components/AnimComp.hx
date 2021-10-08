package components;

class AnimComp {
	public var indices: Array<Int>;
	public var speeddiv: Int;
	public var count: Int;
	public var index: Int;
	
	
	public function new(indices: Array<Int>, speeddiv: Int) {
		this.indices = indices;
		index = 0;
        count = 0;
		this.speeddiv = speeddiv;
	}
    
	public static function createAnimData(index: Int) {
		var indices = [index];
		return new AnimComp(indices, 1);
	}
	
	public static function createAnimDataRange(minindex: Int, maxindex: Int, speeddiv: Int): AnimComp {
		var indices = new Array<Int>();
		for (i in 0...maxindex - minindex + 1) indices.push(minindex + i);
		return new AnimComp(indices, speeddiv);
	}
}