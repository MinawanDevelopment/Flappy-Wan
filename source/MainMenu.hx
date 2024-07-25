package;

import backend.APIStuff;
import backend.BackendCaller;
import backend.NotSoConstant;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxInputText;
import flixel.util.FlxColor;
import haxe.Json;
import objects.TextSprite;

class MainMenu extends FlxState
{
	public var wrTxt:TextSprite;
	public var playTxt:TextSprite;
    public var inputForm:FlxInputText;

	override public function create()
	{
		playTxt = new TextSprite();
		playTxt.text = "Press ENTER to play.";
        playTxt.size = 50;
		playTxt.screenCenter(X);
		playTxt.y = FlxG.height - 50;
		add(playTxt);

		wrTxt = new TextSprite();
        wrTxt.size = 50;
		wrTxt.text = "Loading WR Score";
		wrTxt.screenCenter();
		add(wrTxt);

        inputForm = new FlxInputText(FlxG.width - 200, 100, "", 12, FlxColor.WHITE, FlxColor.GRAY);
        if (NotSoConstant.USERNAME != "") {
            inputForm.text = NotSoConstant.USERNAME;
        } else {
            inputForm.text = "Username Here";
        }
        add(inputForm);

        add(inputForm);

		BackendCaller.sendRequest("/api/wr/get", {"auth": APIStuff.auth_key}, onGotWR, onWRError);

		super.create();
	}

    override public function update(elapsed) {
        super.update(elapsed);


        if (FlxG.keys.justPressed.ENTER) {
            NotSoConstant.USERNAME = inputForm.text;
            FlxG.switchState(new PlayState());
        }
    }

	public function onGotWR(WR)
	{
		// var parsed:Dynamic = Json.parse(WR);
        wrTxt.text = "Record Holder: " + parsed.recordHolder + " | Score: " + parsed.score;
        wrTxt.screenCenter();
	}

    public function onWRError(err) {
        wrTxt.text = "Error: " + err;
        wrTxt.screenCenter();
    }
} 