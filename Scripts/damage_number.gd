class_name DamageNumber extends Node2D

@export var damage_label: Label

func appear(amount: float, travel_distance: float, lifetime: float) -> void:
	damage_label.text = str(amount)
	damage_label.visible = true
	position = Vector2(randf_range(-20, 20), randf_range(-20, 20))
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(
			self, 
			"position", 
			position + Vector2(randf_range(-20, 20), -travel_distance), 
			lifetime
			)
	tween.tween_callback(queue_free)
