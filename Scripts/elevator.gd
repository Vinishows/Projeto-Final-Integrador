extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_door_body_entered(body: Node3D) -> void:
	print("Entrou: ", body.name, ", Pai: ", body.get_parent().name) # Depuração para verificar o nó
	if body.name == "ProtoController" and body.get_parent().name == "Andar_3":
		$AnimationPlayer.play("open_door")

func _on_door_body_exited(body: Node3D) -> void:
	if body.name == "ProtoController" and body.get_parent().name == "Andar_3":
		$AnimationPlayer.play_backwards("open_door")
