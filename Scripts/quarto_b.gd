extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player" and Input.is_action_just_pressed("Interact"):
		print("o caba endoidou")
