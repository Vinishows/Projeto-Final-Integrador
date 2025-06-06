extends Node3D

@onready var blocker_2: CSGBox3D = %blocker2
@onready var blocker_1: CSGBox3D = %blocker1

var player_in_area = false

var obj_interacted = []

func _ready() -> void:
	for obj in get_tree().get_nodes_in_group("objs"):
		obj.obj_interacted.connect(_on_obj_interacted)

func _process(_delta: float) -> void:
	var fade = get_node("CanvasLayer")
	await fade.fade_from_black()
	if player_in_area and Input.is_action_just_pressed("Interact"):
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/andar_2.tscn")

func _on_obj_interacted(nome: String) -> void:
	if nome not in obj_interacted:
		if len(obj_interacted) == 1:
			obj_interacted.clear()
			obj_interacted.append(nome)
		else:
			obj_interacted.append(nome)
		print(obj_interacted)
		Dialogic.VAR.set_variable("current_obj", nome)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		player_in_area = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		player_in_area = false

func _on_area_3d_bloco_1_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		blocker_1.visible = false
		blocker_2.visible = true

func _on_area_3d_bloco_1_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		blocker_1.visible = true
		blocker_2.visible = false

func _on_area_3d_bloco_2_body_entered(body: Node3D) -> void:
	if body.name == "Player_25":
		blocker_1.visible = true
		blocker_2.visible = false

func _on_area_3d_bloco_2_body_exited(body: Node3D) -> void:
	if body.name == "Player_25":
		blocker_1.visible = false
		blocker_2.visible = true
