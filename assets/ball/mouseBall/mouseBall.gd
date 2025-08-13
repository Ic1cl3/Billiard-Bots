extends ball
## Ball, but controlled with the mouse.

var mouseDifference = Vector2.ZERO ## Difference between mouse cursor position and ball position.


func _process(_delta: float) -> void:
	mouseDifference = get_global_mouse_position() - position
	dir = directionalize(mouseDifference)
