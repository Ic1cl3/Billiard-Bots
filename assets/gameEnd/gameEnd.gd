extends TextureRect
## For loading the main menu.
class_name gameEnd


var playerTypes : Array = [0, 0] ## Maintains player type IDs.
var playingTo : int = 0 ## The number of points which must be scored to end the game.


func _ready() -> void:
	modulate = Color(modulate, 0.0) # Set transparent.
	show()
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(modulate, 1), 0.5) # Fade in.
	await tween.finished
	tween.stop()
	var menu : Control = load("res://assets/mainMenu/mainMenu.tscn").instantiate()
	get_parent().add_sibling(menu)
	menu.playerOneSelect.selected = playerTypes[0]
	menu.playerTwoSelect.selected = playerTypes[1]
	menu.roundsSelect.value = playingTo
	tween.tween_property(self, "modulate", Color(modulate, 0.0), 0.5) # Fade out.
	tween.play()
	await tween.finished
	get_parent().queue_free()
