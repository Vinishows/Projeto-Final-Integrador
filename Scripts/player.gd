extends CharacterBody2D

const SPEED = 200.0
var last_direction: String = "right"
@onready var sprite: AnimatedSprite2D = %sprite
@onready var footsteps: AudioStreamPlayer2D = %footsteps

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	velocity = input_vector * SPEED

	# Start playing footsteps if moving
	if input_vector != Vector2.ZERO:
		if not footsteps.playing:
			footsteps.play()

		if abs(input_vector.x) > abs(input_vector.y):
			if input_vector.x > 0:
				last_direction = "right"
				sprite.play("walk")
				sprite.flip_h = false
			else:
				last_direction = "left"
				sprite.play("walk")
				sprite.flip_h = true
		else:
			if input_vector.y > 0:
				last_direction = "front"
				sprite.play("down")
				sprite.flip_h = false
			else:
				last_direction = "back"
				sprite.play("up")
				sprite.flip_h = false
	else:
		# Stop footsteps if idle
		if footsteps.playing:
			footsteps.stop()

		match last_direction:
			"right":
				sprite.play("idle_walk")
				sprite.flip_h = false
			"left":
				sprite.play("idle_walk")
				sprite.flip_h = true
			"front":
				sprite.play("idle_down")
				sprite.flip_h = false
			"back":
				sprite.play("idle_up")
				sprite.flip_h = false

	move_and_slide()
