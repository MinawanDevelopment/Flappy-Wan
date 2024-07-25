package;

import backend.APIStuff;
import backend.BackendCaller;
import backend.NotSoConstant;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import objects.Pipe;
import objects.Player;
import objects.TextSprite;

class PlayState extends FlxState
{
	
	public var score:Int = 0;

	// Sprites and shi
	var player:Player;
	var pipes:FlxSpriteGroup;
	var scoreTxt:TextSprite;

	// Other
	var pipeGap:Float = 200;
	var pipeSpawnTimer:Float = 0;


	override public function create()
	{
		pipes = new FlxSpriteGroup();
		add(pipes);

		scoreTxt = new TextSprite();
		scoreTxt.x = 50;
		scoreTxt.y = 50;
		scoreTxt.size = 30;
		add(scoreTxt);

		player = new Player();
		player.onOutOfBoundsCallback = onPlayerDeath; // Thought I'd experiment with callbacks.
		add(player);



		super.create();
	}

	override public function update(elapsed:Float)
	{
		scoreTxt.text = "Score: " + score;

		super.update(elapsed);

		pipeSpawnTimer += elapsed;
        if (pipeSpawnTimer >= 2) // Spawn a new set of pipes every 2 seconds
        {
            spawnPipes();
            pipeSpawnTimer = 0;
			score += 50;
        }

		for (pipe in pipes) {
			FlxG.overlap(player, pipe, onPlayerDeath);
		}

		
	
		player.tick(elapsed);
	}



	private function spawnPipes():Void
	{
		var screenHeight = FlxG.height;
		
		var gapHeight:Float = 130;
		var randomY:Float = FlxG.random.float(50, FlxG.height - gapHeight - 50);
				
		// Top pipe
		var topPipe:Pipe = new Pipe(FlxG.width, randomY - FlxG.height, 100);
		pipes.add(topPipe);
		// Bottom pipe
		var bottomPipe:Pipe = new Pipe(FlxG.width, randomY + gapHeight, 100);
		pipes.add(bottomPipe);
	}

	public function adjustPipeGap() {
		pipeGap = 200 - Std.int(score) * 2;
        if (pipeGap < 100)
        {
            pipeGap = 100; // Minimum gap
        }
	}
	// Runs when the silly minawan falls off the screen!
	public function onPlayerDeath(?player, ?pipe) {
		trace("Your fucking dead fool");
		// var request = {
		// 	"auth" : APIStuff.auth_key,
		// 	"submitter" : NotSoConstant.USERNAME,
		// 	"score" : score
		// }
		// BackendCaller.sendRequest("/api/score/submit", request, onScoreSubmit, onScoreError);
		onScoreSubmit("ITCH.IO doesn't like webservers like mine so heres a placeholder fake result.");
	}

	public function onScoreSubmit(response) {
		trace("Response: " + response);
		FlxG.switchState(new MainMenu());
	}

	public function onScoreError(err) {
		trace("Error: " + err);
		FlxG.switchState(new MainMenu());
	}
}
