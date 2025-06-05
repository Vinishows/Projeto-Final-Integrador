extends Node3D

var player_in_area = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("Interact"):
		pass #TROCAR POR TRANSIÇÃO DE CENA DE VOLTA PARA O CORREDOR

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_in_area = false
