extends Node3D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _process(delta: float) -> void:
	pass

func _on_door_body_entered(body: Node3D) -> void:
	if body.name == "ProtoController" and body.get_parent().name == "Andar_3":
		animation_player.play("open_door")

func _on_door_body_exited(body: Node3D) -> void:
	if body.name == "ProtoController" and body.get_parent().name == "Andar_3":
		animation_player.play_backwards("open_door")
