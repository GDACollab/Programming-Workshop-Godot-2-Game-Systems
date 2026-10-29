class_name SurvivorsEntitySpawner extends Node

@export var enemy_types: Array[PackedScene]
@export var spawn_rect: CollisionShape2D = null
@export var on_screen_enemy_limit: int = 10
var _enemy_count: int = 0

func _ready() -> void:
	## TODO:
	## Use a Timer to repeatedly spawn new enemies!
	
	spawn_entity() # <--- replace this

func spawn_entity() -> void:
	if (_enemy_count >= on_screen_enemy_limit):
		return
	
	var spawn_point := get_spawn_point()
	var random_enemy_type_index = randi_range(0, enemy_types.size() - 1)
	
	var enemy_to_spawn = enemy_types[random_enemy_type_index]
	var spawned_enemy = enemy_to_spawn.instantiate()
	spawned_enemy.global_position = spawn_point
	increment_enemy_count()
	spawned_enemy.on_death.connect(decrement_enemy_count)
	spawned_enemy.on_spawn()
	get_tree().root.get_node("Survivors").add_child.call_deferred(spawned_enemy)


func get_spawn_point() -> Vector2:
	var spawn_point := Vector2.ZERO
	if spawn_rect == null: 
		return spawn_point
	var rect_bounds = spawn_rect.shape.get_rect()
	spawn_point.x = spawn_rect.global_position.x + randi_range(-(rect_bounds.size.x / 2), (rect_bounds.size.x / 2))
	spawn_point.y = spawn_rect.global_position.y + randi_range(-(rect_bounds.size.y / 2), (rect_bounds.size.y / 2))
	return spawn_point

func increment_enemy_count() -> void:
	_enemy_count += 1
	print("enemy count: ", str(_enemy_count))

func decrement_enemy_count() -> void:
	_enemy_count -= 1
	print("enemy count: ", str(_enemy_count))

func _process(_delta: float) -> void:
	pass
