extends CharacterBody2D

const SPEED = 200.0
var last_direction: String = "right"

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	# Atualiza a velocidade com base no input
	velocity = input_vector * SPEED

	if input_vector != Vector2.ZERO:
		if abs(input_vector.x) > abs(input_vector.y):
			if input_vector.x > 0:
				last_direction = "right"
				$sprite.play("walk")
				$sprite.flip_h = false
			else:
				last_direction = "left"
				$sprite.play("walk")
				$sprite.flip_h = true
		else:
			if input_vector.y > 0:
				last_direction = "front"
				$sprite.play("down")
				$sprite.flip_h = false
			else:
				last_direction = "back"
				$sprite.play("up")
				$sprite.flip_h = false
	else:
		match last_direction:
			"right":
				$sprite.play("idle_walk")
				$sprite.flip_h = false
			"left":
				$sprite.play("idle_walk")
				$sprite.flip_h = true
			"front":
				$sprite.play("idle_down")
				$sprite.flip_h = false
			"back":
				$sprite.play("idle_up")
				$sprite.flip_h = false

	move_and_slide()
