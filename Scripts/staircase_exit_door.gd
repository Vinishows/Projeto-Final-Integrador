extends StaticBody3D

signal exit_interacted

var player_in_area = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		print(Input.is_action_just_pressed("Interact"))
		exit_interacted.emit()

func _on_area_3d_body_entered(body):
	print(body.name)
	if body.name == "ProtoController":
		player_in_area = true

func _on_area_3d_body_exited(body):
	print(body.name)
	if body.name == "ProtoController":
		player_in_area = false
