extends CharacterBody3D

# Hello programmer!!!!!
# Pls change these to be an export variables!!!
var kick_force: int = 2
var mouse_sens: float = 0.01

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Refrences
@export var camera_holder: Node3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		camera_holder.rotate_y(-event.relative.x * mouse_sens)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_up", "ui_down", "ui_right", "ui_left")
	var direction := (camera_holder.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# dis is for kickin da ball
	# use get_slide_collision_count() to get all colliders the characterBody3D collided with this physics frame
	# if any of them are a RigidBody3D (like the bouncy ball!)
	# 	use RigidBody3D.apply_central_impulse to kick the ball
	# 	and collision.get_normal() to get the normal direction of the collision
	#	the normal goes inward from the point of collision, which is why we inverse it by making it negative
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var kick_direction = -collision.get_normal()
			collider.apply_central_impulse(kick_direction * kick_force)
		
