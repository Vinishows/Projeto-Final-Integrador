extends Node2D

var go_back = false
var obj_interacted = []

func _ready() -> void:
	for obj in get_tree().get_nodes_in_group("objs"):
		obj.obj_interacted.connect(_on_obj_interacted)

func _process(delta: float) -> void:
	if go_back and Input.is_action_just_pressed("Interact"):
		get_tree().change_scene_to_file("res://Scenes/andar_1.tscn")

func _on_carpet_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		go_back = true

func _on_carpet_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		go_back = false

func _on_obj_interacted(nome: String) -> void:
	if nome not in obj_interacted:
		if len(obj_interacted) == 1:
			obj_interacted.clear()
			obj_interacted.append(nome)
		else:
			obj_interacted.append(nome)
		print(obj_interacted)
		Dialogic.VAR.set_variable("current_obj", nome)
