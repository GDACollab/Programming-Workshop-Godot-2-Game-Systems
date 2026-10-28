class_name ReticleLine extends Node2D
@export var line: Line2D
@export var raycast: RayCast2D

func _process(delta: float) -> void:
	line.clear_points()
	
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	raycast.target_position = mouse_position - global_position
	line.add_point(position)
	if raycast.get_collision_point() and raycast.is_colliding(): 
		line.add_point(raycast.get_collision_point() - global_position)
	else:
		line.add_point(mouse_position - global_position)
	
