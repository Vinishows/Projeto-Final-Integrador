extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var player_in_area = false

signal obj_interacted(nome: String)

var nome = "crazy"

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		emit_signal("obj_interacted", nome)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animated_sprite_2d.visible = true
		player_in_area = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		animated_sprite_2d.visible = false
		player_in_area = false
