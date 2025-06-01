extends Node

@export var correct_order: Array[int] = [0, 1, 2] # Exemplo
@export var player_path: NodePath = "ProtoController"
@export var fade_path: NodePath = "CanvasLayer"

@onready var exit_door = $staircase_exitDoor
@onready var staircase: Node3D = %staircase
@onready var floor_structure: CSGCombiner3D = %floor_structure

var current_step = 0

func _ready():
	exit_door.exit_interacted.connect(_on_exit_interacted)
	
	for door in get_tree().get_nodes_in_group("doors"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	if door_id == correct_order[current_step]:
		current_step += 1
		if current_step == correct_order.size():
			var fade = get_node("CanvasLayer")
			await fade.fade_to_black()
			remove_child(floor_structure)
			staircase.visible = true
			await fade.fade_from_black()
		else:
			await fade_and_teleport()
	else:
		current_step = 0
		await fade_and_teleport()

func fade_and_teleport():
	var fade = get_node("CanvasLayer")
	var player = get_node("ProtoController")
	await fade.fade_to_black()
	player.global_position = Vector3(9.3, 0.497, 10.138)
	await fade.fade_from_black()
	
func _on_exit_interacted():
	if current_step == correct_order.size():
		print("Level Completed!")
