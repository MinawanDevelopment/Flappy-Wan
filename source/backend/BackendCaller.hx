package backend;

import haxe.Http;
import haxe.Json;

class BackendCaller
{
	public static function sendRequest(path, body:Dynamic, onComplete, onError)
	{
		var http:Http = new Http(APIStuff.url + path);
		var stringJson = Json.stringify(body);

		http.setHeader("Content-Type", "application/json");

		http.onData = function(response:String)
		{
			onComplete(response);
		}

		http.onError = function(error:String)
		{
			onError(error);
		}

		http.setPostData(stringJson);
		http.request(true);
	}

	public function sendGetRequest(url, onComplete, onError)
	{
		var http:Http = new Http(url);

		http.onData = function(response:String)
		{
			onComplete(response);
		}

		http.onError = function(error:String)
		{
			onError(error);
		}

		http.request(false);
	}
}