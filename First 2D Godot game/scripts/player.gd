extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_spirite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite 
	if direction > 0:
		animated_spirite.flip_h = false
	elif direction < 0:
		animated_spirite.flip_h = true
	
	# Play animations 
	if is_on_floor():
		if direction == 0:
			animated_spirite.play("idle")
		else :
			animated_spirite.play("run")
	else :
		animated_spirite.play("jump")
	
	
	# Apply movment
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
