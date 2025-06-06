extends StaticBody3D

@onready var qm_sprite: AnimatedSprite3D = %qm_sprite

var player_in_area = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		print("Quer entrar no culto da maconha hehehehhehe")

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		qm_sprite.visible = true
		player_in_area = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		qm_sprite.visible = false
		player_in_area = false
