extends RigidBody2D
## Default class for all "Ball" objects.
class_name ball


@export var friction : float ## Friction coefficient


func _ready() -> void:
	apply_central_impulse(Vector2(100,0))


func _physics_process(delta: float) -> void:
	pass
