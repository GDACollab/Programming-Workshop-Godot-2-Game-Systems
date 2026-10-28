class_name SurvivorsPlayer extends SurvivorsEntity

@export var reticle_line: ReticleLine

func get_move_direction() -> Vector2:
	var move_direction: Vector2
	move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_direction = move_direction.normalized()
	return move_direction

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot")):
		#---REPLACE---
		# Use the raycast to shoot towards a collider!
		
		pass
