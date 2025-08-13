extends ball
## Ball, but controlled with WASD.

var inputVector = Vector2.ZERO ## Vector of directional inputs.


func _process(_delta: float) -> void:
	inputVector = Input.get_vector("a", "d", "w", "s").normalized()
	if inputVector == Vector2.ZERO: # Keeps still via constant flipping if there are no inputs.
		dir += 180
	else:
		dir = directionalize(inputVector)
