class_name DamageNumberSpawner extends Node2D

@export var travel_distance: float = 25.0
@export var lifetime: float = 1.0
@export var entity: SurvivorsEntity
var damage_number_scene = preload("res://Scenes/Damage Number/damage_number.tscn")

func _ready() -> void:
	# Subscribe to a signal in SurvivorsEntity!
	entity.on_hurt.connect(spawn_damage_number)
	
	pass

func spawn_damage_number(damage: float) -> void:
	var spawned_damage_number = damage_number_scene.instantiate()
	spawned_damage_number.appear(damage, travel_distance, lifetime)
	add_child(spawned_damage_number)
