package objects;

import flixel.FlxG;
import flixel.FlxSprite;

class Pipe extends FlxSprite
{
    public var speed:Float;

    public function new(x:Float, y:Float, speed:Float)
    {
        super(x, y);
        makeGraphic(40, FlxG.height, 0xff00ff00); // Green pipe
        this.speed = speed;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        // Move the pipe to the left
        x -= speed * elapsed;

        // Destroy the pipe if it's off-screen
        if (x + width < 0)
        {
            kill();
        }
    }
}
