extends CharacterBody3D

@onready var sprite: AnimatedSprite3D = %sprite

@export var jump_velocity : float = 4.5

const SPEED = 5.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if direction.x > 0:
			sprite.flip_h = false
			sprite.play("walk")
		elif velocity.x < 0:
			sprite.flip_h = true
			sprite.play("walk")
		elif velocity.z < 0:
			sprite.play("up")
		else:
			sprite.play("down")
			
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		sprite.stop()
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = jump_velocity

	move_and_slide()
