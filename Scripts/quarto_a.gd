extends Node2D

var go_back = false

func _process(delta: float) -> void:
	if go_back and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/andar_1.tscn")

func _on_carpet_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		go_back = true

func _on_carpet_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		go_back = false
