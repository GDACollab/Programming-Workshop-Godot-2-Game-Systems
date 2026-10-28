class_name SurvivorsEntity extends CharacterBody2D
@export var move_speed: float = 300.0
@export var max_health: float = 10.0
@export var damage: float = 1.0
var current_health: float

# ---REPLACE---
# Add a custom signal for getting hurt!
signal on_hurt(float)
signal on_death

func on_spawn() -> void:
	current_health = max_health
	pass

func take_damage(amount: float) -> void:
	current_health -= amount
	# ---REPLACE---
	# Emit a custom signal here for getting hurt!
	on_hurt.emit(amount)
	if current_health <= 0:
		die()

func die() -> void:
	on_death.emit()
	queue_free()

func _physics_process(delta: float) -> void:
	var move_direction := get_move_direction()
	
	if move_direction.x != 0:
		velocity.x = move_direction.x * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if move_direction.y != 0:
		velocity.y = move_direction.y * move_speed
	else:
		velocity.y = move_toward(velocity.y, 0, move_speed)
	
	move_and_slide()

func get_move_direction() -> Vector2:
	return Vector2.ZERO

func attack(entity: SurvivorsEntity) -> void:
	print("ouch!")
	entity.take_damage(damage)
