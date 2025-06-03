extends Node2D

@export var fade_path: NodePath = "CanvasLayer"
@onready var canvas_layer: CanvasLayer = %CanvasLayer

func _ready():
	canvas_layer.visible = true
	for door in get_tree().get_nodes_in_group("doors_2d"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	var fade = get_node("CanvasLayer")
	var door1 = get_node("door_2D/AnimatedSprite2D")
	var door2 = get_node("door_2D2/AnimatedSprite2D")
	var door3 = get_node("door_2D3/AnimatedSprite2D")
	if door_id == 1:
		door1.play("door")
		await fade.fade_to_black()
		print("Porta da casa do prota")
		door1.stop()
		await fade.fade_from_black()
	elif door_id == 2:
		door2.play("door")
		await fade.fade_to_black()
		print("Porta da casa abandonada")
		door2.stop()
		await fade.fade_from_black()
	else:
		door3.play("door")
		await fade.fade_to_black()
		print("Porta da casa do louco")
		door3.stop()
		await fade.fade_from_black()
