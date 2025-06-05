@tool
extends Node3D
class_name IntObj3D

@onready var animated_sprite_3d: AnimatedSprite3D = %AnimatedSprite3D

@export var nome: String

@export var offset: Vector3:

	set(new_offset):
		offset = new_offset
		if animated_sprite_3d:
			animated_sprite_3d.position = offset

var player_in_range := false

func _ready() -> void:
	animated_sprite_3d.position = offset

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("Interact"):
		print("Interacted with: ", nome)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		player_in_range = true
		animated_sprite_3d.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		player_in_range = false
		animated_sprite_3d.visible = false
