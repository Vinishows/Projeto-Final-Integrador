extends CharacterBody3D


@onready var sprite: AnimatedSprite3D = %sprite
@onready var footsteps: AudioStreamPlayer3D = %footsteps

@export var jump_velocity : float = 0
@export var SPEED : int = 5

var last_direction: String = "right"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		if is_on_floor() and not footsteps.playing:
			footsteps.play()

		if direction.x > 0:
			last_direction = "right"
			sprite.flip_h = false
			sprite.play("walk")
		elif velocity.x < 0:
			last_direction = "left"
			sprite.flip_h = true
			sprite.play("walk")
		elif velocity.z < 0:
			last_direction = "up"
			sprite.play("up")
		else:
			last_direction = "down"
			sprite.play("down")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

		if footsteps.playing:
			footsteps.stop()

		match last_direction:
			"right":
				sprite.play("idle-walk")
				sprite.flip_h = false
			"left":
				sprite.play("idle-walk")
				sprite.flip_h = true
			"down":
				sprite.play("idle-down")
			"up":
				sprite.play("idle-up")

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
