extends Node2D
## Script for the game room itself.
class_name gameRoom


@onready var overtimeTimer = $overtimeTimer ## Access to overtime timer node.
@onready var drawTimer = $drawTimer ## Access to the draw timer node.
@onready var countdown = $countdown ## Access to countdown label.
@onready var score = $score ## Access to the scorecard node.
@onready var playerOne : ball ## Access to player one ball node.
@onready var playerTwo : ball ## Access to player two ball node.


var playingTo : int = 0 ## The number of points which must be scored to end the game.
var playerOneScore : int = 0 ## Player one's current number of points.
var playerTwoScore : int = 0 ## Player two's current number of points.
var lockedWinner : int = -1 ## Tracks who has officially won as an int from -1 through 2, meaning no one, player one, player two, and a draw respectively.
var overtime : bool = false ## Tracks whether or not the label should display the 10 second draw timer in overtime.
var finishing : bool = false ## Tracks whether or not the round is actively ending.
var playerTypes : Array = [0, 0] ## Maintains player type IDs.


func _ready() -> void:
	var countdownSpeed : float = 0.75
	score.text = ""
	for child in get_children(): # Stops all child activity.
		child.process_mode = Node.PROCESS_MODE_DISABLED
	countdown.text = "3" # Countdown.
	await get_tree().create_timer(countdownSpeed).timeout
	countdown.text = "2"
	await get_tree().create_timer(countdownSpeed).timeout
	countdown.text = "1"
	await get_tree().create_timer(countdownSpeed).timeout
	countdown.text = "GO"
	await get_tree().create_timer(countdownSpeed).timeout
	countdown.text = ""
	for child in get_children(): # Restores all child activity.
		child.process_mode = Node.PROCESS_MODE_INHERIT
		if child is ball: # Tells balls that the game has begun.
			child.action = true
	overtimeTimer.start()


func _physics_process(_delta: float) -> void:
	if playerOne.falling and playerTwo.falling and lockedWinner == -1: # Checks if someone has won or the game has drawn every physics frame.
		lockedWinner = 2
	elif playerOne.falling and lockedWinner == -1:
		lockedWinner = 1
	elif playerTwo.falling and lockedWinner == -1:
		lockedWinner = 0
	elif lockedWinner != -1 and not finishing:
		finish()
	if overtime: # Visualizes countdown in overtime.
		countdown.text = str(roundf(drawTimer.time_left * 100)/100)
		countdown.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	else:
		countdown.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


func finish() -> void:
	finishing = true
	playerOne.action = false
	playerTwo.action = false
	countdown.size.x = 500 # Adjusts countdown box to display winner.
	countdown.position.x -= 185
	countdown.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	if lockedWinner == 2: # Display round winner and add points.
		countdown.text = "Draw"
	elif lockedWinner == 1:
		playerTwoScore += 1
		countdown.text = "Blue"
	else:
		playerOneScore += 1
		countdown.text = "Red"
	score.text = "x - x".format([playerOneScore, playerTwoScore], "x") # Display score
	if playerOneScore >= playingTo or playerTwoScore >= playingTo: # Decides whether round win or game win.
		countdown.text += " Wins All"
		await get_tree().create_timer(3).timeout
		var gameEndNode : TextureRect = load("res://assets/gameEnd/gameEnd.tscn").instantiate()
		gameEndNode.playerTypes = playerTypes
		gameEndNode.playingTo = playingTo
		gameEndNode.position = Vector2(576, 324)
		add_child(gameEndNode)
	else:
		if lockedWinner != 2: # Prevents from label displaying "Draw Wins."
			countdown.text += " Wins"
		await get_tree().create_timer(3).timeout
		var gameStartNode : TextureRect = load("res://assets/gameStart/gameStart.tscn").instantiate()
		gameStartNode.playerOne = playerTypes[0]
		gameStartNode.playerTwo = playerTypes[1]
		gameStartNode.playingTo = playingTo
		gameStartNode.playerOneScore = playerOneScore
		gameStartNode.playerTwoScore = playerTwoScore
		gameStart.position = Vector2(576, 324)
		add_child(gameStartNode)

func _on_battle_zone_body_exited(body: Node2D) -> void: # Ejects balls which leave the arena.
	if body is ball:
		body.eject()


func _on_overtime_timer_timeout() -> void: # Begins 10 second countdown to draw the game if it takes more than 50 seconds.
	drawTimer.start()
	overtime = true


func _on_draw_timer_timeout() -> void: # draw the game on timeout.
	lockedWinner = 2
	overtime = false
	playerOne.eject(5)
	playerTwo.eject(5)
