extends Node3D

func _process(delta: float) -> void:
	pass

func _on_door_body_entered(body: Node3D) -> void:
	print("Entrou: ", body.name, ", Pai: ", body.get_parent().name) # Depuração para verificar o nó
	if body.name == "ProtoController" or "Player_25" and body.get_parent().name == "Andar_3" or "Andar_2":
		$AnimationPlayer.play("open_door")

func _on_door_body_exited(body: Node3D) -> void:
	if body.name == "ProtoController" or "Player_25" and body.get_parent().name == "Andar_3" or "Andar_2":
		$AnimationPlayer.play_backwards("open_door")
