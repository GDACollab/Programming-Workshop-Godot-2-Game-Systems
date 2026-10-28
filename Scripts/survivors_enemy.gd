class_name SurvivorsEnemy extends SurvivorsEntity

func get_move_direction() -> Vector2:
	# ---REPLACE---
	# Move towards the player obtained from a Singleton!
	var player_position = GameManager.player.global_position
	var to_player = player_position - global_position
	var direction = to_player.normalized()
	return direction
