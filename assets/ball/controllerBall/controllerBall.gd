extends ball
# Ball, but controlled with a controller.

var inputVector = Vector2.ZERO ## Vector of directional inputs.


func _process(_delta: float) -> void:
	inputVector = Vector2(Input.get_axis("controllerLeft", "controllerRight"), Input.get_axis("controllerUp", "controlllerDown"))
	if abs(inputVector.x) + abs(inputVector.y) < 0.2: # Keeps still via constant flipping if there are no or deadzoned inputs.
		dir += 180
	else:
		dir = directionalize(inputVector)
