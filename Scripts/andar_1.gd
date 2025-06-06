extends Node2D

@export var fade_path: NodePath = "CanvasLayer"
@onready var canvas_layer: CanvasLayer = %CanvasLayer

var next_level = false

func _ready():
	canvas_layer.visible = true
	for door in get_tree().get_nodes_in_group("doors_2d"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	var fade = get_node("CanvasLayer")
	var door2 = get_node("door_2D2/AnimatedSprite2D")
	var door3 = get_node("door_2D3/AnimatedSprite2D")
	
	if door_id == 1:
		print("Não tem por que voltar pra dentro")
	elif door_id == 2:
		door2.play("door")
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/quarto_c.tscn")
	else:
		door3.play("door")
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/quarto_b.tscn")

func _on_elevator_collision_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		next_level = true

func _on_elevator_collision_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		next_level = false

func _process(delta: float) -> void:
	if next_level and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/andar_2.tscn")
