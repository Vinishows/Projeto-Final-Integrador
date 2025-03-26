extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var last_direction: String = "left"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$sprite.play("jump_right")
		velocity.y = JUMP_VELOCITY

	# Get the input direction.
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_left", "ui_right")
	).normalized()

	# Update velocity based on input.
	velocity.x = direction.x * SPEED
	
	if direction != Vector2.ZERO:
		if direction.x < 0:
			last_direction = "left"
		elif direction.x > 0:
			last_direction = "right"

		$sprite.play("walk_" + last_direction)
	else:
		# Character is idle.
		$sprite.play("idle_" + last_direction)

	move_and_slide()
	print(is_on_floor())
