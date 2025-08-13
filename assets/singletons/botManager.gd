extends Node
## Singleton for managing interactions with bots.

var defaultTempIn : Dictionary = { ## Default data 
	"opponentDirection" : 1,
	"positionX" : 0,
	"positionY" : 0,
	"opponentPositionX" : 0,
	"opponentPositionY" : 0,
	"velocityX" : 0,
	"velocityY" : 0,
	"opponentVelocityX" : 0,
	"opponentVelocityY" : 0,
	"action" : false
}
var defaultTempOut : Dictionary = {
	"direction" : 0.0
}


var botOnePath : String = "" ## Bot one's directory path.
var botTwoPath : String = "" ## Bot two's directory path.

## Loads a directory as a bot into the specified slot number.
func openBot(path : String, botNum : int) -> void:
	var tempIn : FileAccess = FileAccess.open(path + "/tempIn.json", FileAccess.WRITE_READ)
	var tempOut : FileAccess = FileAccess.open(path + "/tempOut.json", FileAccess.WRITE_READ)
	tempIn.store_string(JSON.stringify(defaultTempIn))
	tempOut.store_string(JSON.stringify(defaultTempOut))
	
	if botNum == 0:
		botOnePath = path
	else:
		botTwoPath = path

## Sends data to the given bot's tempIn.json file.
func setData(data : Dictionary, bot : int) -> void:
	if bot == 0 and FileAccess.file_exists(botOnePath + "/tempIn.json"):
		var tempIn : FileAccess = FileAccess.open(botOnePath + "/tempIn.json", FileAccess.WRITE)
		tempIn.store_string(JSON.stringify(data))
		tempIn.close
	elif FileAccess.file_exists(botTwoPath + "/tempIn.json"):
		var tempIn : FileAccess = FileAccess.open(botTwoPath + "/tempIn.json", FileAccess.WRITE)
		tempIn.store_string(JSON.stringify(data))
		tempIn.close()

## Retreives the direction property (only bot output property) of the given bot. Returns 0 iv there is an error retrieving the data.
func getDir(bot : int):
	if bot == 0 and FileAccess.file_exists(botOnePath + "/tempOut.json"): # Only proceed if file exists.
		var tempOut : FileAccess = FileAccess.open(botOnePath + "/tempOut.json", FileAccess.READ)
		var tempOutDict = JSON.parse_string(tempOut.get_line())
		tempOut.close()
		if tempOutDict != null: # Only proceed if JSON is valid and could be parsed.
			var direction = tempOutDict.get("direction")
			if direction != null: # Only proceed if direction is a valid dictionary key.
				return direction
	elif FileAccess.file_exists(botTwoPath + "/tempOut.json"): # Mirrored from top, but with bot two path.
		var tempOut : FileAccess = FileAccess.open(botTwoPath + "/tempOut.json", FileAccess.READ)
		var tempOutDict = JSON.parse_string(tempOut.get_line())
		tempOut.close()
		if tempOutDict != null:
			var direction = tempOutDict.get("direction")
			if direction != null:
				return direction
	return 0.0 # Returns zero if could not proceed at any point.
