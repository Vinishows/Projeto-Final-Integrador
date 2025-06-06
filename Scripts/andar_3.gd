extends Node

@export var correct_order: Array[int] = [1, 3, 2] #[1, 3, 1, 2, 1, 3, 1, 2]

@onready var exit_door = $staircase_exitDoor
@onready var staircase: Node3D = %staircase
@onready var floor_structure: CSGCombiner3D = %floor_structure
@onready var number_2: AnimatedSprite3D = %number_2

@onready var wall2 = get_node("staircase/stairway/wall2")
@onready var wall3 = get_node("staircase/stairway/wall3")
@onready var wall4 = get_node("staircase/stairway/wall4")
@onready var door2_interact = get_node("door2/CollisionShape3D")

var current_step = 0

func _ready():
	wall2.disabled = true
	wall3.disabled = true
	wall4.disabled = true
	exit_door.exit_interacted.connect(_on_exit_interacted)
	
	for door in get_tree().get_nodes_in_group("doors"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	if door_id == correct_order[current_step]:
		current_step += 1
		if len(correct_order) - current_step == 1:
			number_2.visible = true
			
		if current_step == correct_order.size():
			var fade = get_node("CanvasLayer")
			await fade.fade_to_black()
			remove_child(floor_structure)
			number_2.visible = false
			staircase.visible = true
			wall2.disabled = false
			wall3.disabled = false
			wall4.disabled = false
			door2_interact.disabled = true
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
		get_tree().change_scene_to_file("res://Scenes/terrace.tscn")
