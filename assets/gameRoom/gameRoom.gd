extends Node2D
## Script for the game room itself.

func _on_battle_zone_body_exited(body: Node2D) -> void: # Ejects balls which leave the arena.
	if body is ball:
		body.eject()
