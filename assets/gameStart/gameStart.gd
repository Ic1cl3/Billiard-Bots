extends TextureRect
## For loading an individual game.
class_name gameStart

var playerScenes : Dictionary = { ## Dictionary for each file path of the various "ball" types. 0 - 3 means either WASD, Controller, Mouse, or AI respectively.
	0 : "res://assets/ball/wasdBall/wasdBall.tscn",
	1 : "res://assets/ball/controllerBall/controllerBall.tscn",
	2 : "res://assets/ball/mouseBall/mouseBall.tscn",
	3 : "res://assets/ball/aiBall/aiBall.tscn"
}


var playerOne : int = 0 ## Number from 0 - 3, representing whether player one is controlled via WASD, mouse, controller, or a bot respectively.
var playerTwo : int = 0 ## Number from 0 - 3, representing whether player two is controlled via WASD, mouse, controller, or a bot respectively.
var playingTo : int = 0 ## The number of points which must be scored to end the game.
var playerOneScore : int = 0 ## Player one's current number of points.
var playerTwoScore : int = 0 ## Player two's current number of points.


func _ready() -> void:
	modulate = Color(modulate, 0.0) # Set transparent.
	show()
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(modulate, 1), 0.5) # Fade in.
	await tween.finished
	var gameRoomNode : Node2D = load("res://assets/gameRoom/gameRoom.tscn").instantiate() # Begins setting up the gameRoom scene.
	var playerOneNode : ball = load(playerScenes.get(playerOne)).instantiate()
	var playerTwoNode : ball = load(playerScenes.get(playerTwo)).instantiate()
	playerOneNode.team = 0
	playerTwoNode.team = 1
	playerOneNode.position = Vector2(420, 324)
	playerTwoNode.position = Vector2(732, 324)
	playerOneNode.opponent = playerTwoNode
	playerTwoNode.opponent = playerOneNode
	gameRoomNode.add_child(playerOneNode)
	gameRoomNode.add_child(playerTwoNode)
	gameRoomNode.playerOne = playerOneNode
	gameRoomNode.playerTwo = playerTwoNode
	gameRoomNode.playingTo = playingTo
	gameRoomNode.playerOneScore = playerOneScore
	gameRoomNode.playerTwoScore = playerTwoScore
	gameRoomNode.playerTypes = [playerOne, playerTwo]
	get_parent().add_sibling(gameRoomNode)
	get_parent().queue_free() # Removes self and previous menu.
