extends StaticBody2D

var player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		print("Amigaaa")

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_area = false
