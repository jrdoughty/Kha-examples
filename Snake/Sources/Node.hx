import kha2d.Sprite;

class Node extends Sprite
{
	public var turnsSinceOccupied:Int = -1;

	public function occupied():Bool
	{
		return turnsSinceOccupied >= 0;
	}
}