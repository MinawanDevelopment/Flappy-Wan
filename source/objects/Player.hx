package objects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class Player extends FlxSprite
{
    var gravity:Float = 400;  // Gravity pulling the player down
    var jumpStrength:Float = -200;  // The strength of the jump
    var velocityY:Float = 0;  // The player's vertical velocity

    public var onOutOfBoundsCallback:Dynamic;

    public function new()
    {
        super();
        loadGraphic("assets/images/minawan.png");
        scale.set(1.5, 1.5);
        // Initial y position (assuming starting from the middle of the screen)
        x = 50;  // Starting x position
        y = 50;
    }

    public function tick(elapsed:Float)
    {
        // Apply gravity
        velocityY += gravity * elapsed;
        y += velocityY * elapsed;

        // Jump on SPACE key press
        if (FlxG.keys.justPressed.SPACE)
        {
            velocityY = jumpStrength;
        }

        // I'll manage this externally
        if (y > FlxG.height && onOutOfBoundsCallback != null) {
            onOutOfBoundsCallback();
        }
    }


}
