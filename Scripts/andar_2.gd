extends Node3D

var next_level = false

func _ready() -> void:
	for door in get_tree().get_nodes_in_group("doors"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	if door_id == 4:
		print("Não vai tar dando viu")
	elif door_id == 5:
		var fade = get_node("CanvasLayer")
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/room_25d.tscn")
	else:
		print("Quem bloqueou isso?")

func _on_elevator_transition_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		next_level = true

func _on_elevator_transition_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		next_level = false
		
func _process(delta):
	if next_level and Input.is_action_just_pressed("Interact"):
		var fade = get_node("CanvasLayer")
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/andar_3.tscn")
