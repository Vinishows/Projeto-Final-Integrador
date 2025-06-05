@tool
extends Node2D
class_name IntObj

@onready var area_2d: Area2D = %Area2D
@onready var sprite_2d: Sprite2D = %Sprite2D

@export var size_button: bool:
	set(new_size_button):
		if area_2d:
			var new_area2d_scale: Vector2 = Vector2(1, 1)/ scale
			area_2d.scale = new_area2d_scale

@export var nome: String

@export var offset: Vector2:
	set(new_offset):
		offset = new_offset
		if area_2d:
			area_2d.position = offset

@export var sprite: CompressedTexture2D:
	set(new_sprite):
		sprite = new_sprite
		if sprite_2d:
			sprite_2d.texture = sprite

var player_in_range := false

func _ready():
	sprite_2d.texture = sprite
	area_2d.position = offset
	var new_area2d_scale: Vector2 = Vector2(1, 1)/ scale
	area_2d.scale = new_area2d_scale

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		print("Interacted with: ", nome)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		print(player_in_range)
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		print(player_in_range)
