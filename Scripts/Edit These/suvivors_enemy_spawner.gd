class_name SurvivorsEntitySpawner extends Node


## TODO:
## Change this enemey stats list to an Array of your EnemyStats Resource!
@export var enemy_stats_list: Array[PackedScene] # <---- Change this
@export var spawn_rect: CollisionShape2D = null
@export var on_screen_enemy_limit: int = 10
var enemy_scene = preload("res://Scenes/Helper Scenes/Entities/survivors_enemy.tscn")
var _enemy_count: int = 0

func _ready() -> void:
	## TODO:
	## Use a Timer to repeatedly spawn new enemies!
	spawn_entity() # <--- replace this

func spawn_entity() -> void:
	if (_enemy_count >= on_screen_enemy_limit):
		return
	
	## TODO:
	## Get a random EnemyStat resource from the enemy_stats_list...
	# var random_enemy_stats_index = randi_range(0, enemy_stats_list.size() - 1)
	
	var spawn_point := get_spawn_point()
	var spawned_enemy = enemy_scene.instantiate()
	spawned_enemy.global_position = spawn_point
	increment_enemy_count()
	spawned_enemy.on_death.connect(decrement_enemy_count)
	
	## TODO:
	## ... and set our newly spawned enemy's stats using it!
	
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
