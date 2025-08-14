extends ball
## Ball, but controlled by a bot.
class_name aiBall


var ballData : Dictionary = {
	"opponentDirection" : 1.0,
	"positionX" : 0.0,
	"positionY" : 0.0,
	"opponentPositionX" : 0.0,
	"opponentPositionY" : 0.0,
	"velocityX" : 0.0,
	"velocityY" : 0.0,
	"opponentVelocityX" : 0.0,
	"opponentVelocityY" : 0.0,
	"action" : false
}


func _process(_delta: float) -> void:
	# Get dir from bot.
	dir = botManager.getDir(team)
	# Set properties.
	ballData = {
		"opponentDirection" : opDir,
		"positionX" : pos.x,
		"positionY" : pos.y,
		"opponentPositionX" : opPos.x,
		"opponentPositionY" : opPos.y,
		"velocityX" : velocity.x,
		"velocityY" : velocity.y,
		"opponentVelocityX" : opVelocity.x,
		"opponentVelocityY" : opVelocity.y,
		"action" : action
	}
	# Send properties to bot.
	botManager.setData(ballData, team)
