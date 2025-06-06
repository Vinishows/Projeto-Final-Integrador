extends Node2D

@onready var day: Label = %day
@onready var event_starter: CanvasLayer = %event_starter
@onready var fade: CanvasLayer = %fade
@onready var player: CharacterBody2D = %Player

var go_back = false
var obj_interacted = []
var current_day = 1
var waiting_for_input = true
var num_obj_int = 0
var aux = []
var player_start_position:= Vector2(481.0, 311.0)

func _ready():
	_show_day_screen()
	player.global_position = player_start_position

	for obj in get_tree().get_nodes_in_group("objs"):
		obj.obj_interacted.connect(_on_obj_interacted)

func _process(_delta: float) -> void:
	Dialogic.VAR.current_day = current_day

	if go_back and Input.is_action_just_pressed("Interact") and not waiting_for_input and current_day == 7:
		fade.visible = true
		await fade.fade_to_black()
		get_tree().change_scene_to_file("res://Scenes/andar_1.tscn")

	if waiting_for_input and Input.is_action_just_pressed("Interact"):
		await fade.fade_to_black()
		event_starter.visible = false
		waiting_for_input = false
		await fade.fade_from_black()
		fade.visible = false

func _on_carpet_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		go_back = true

func _on_carpet_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		go_back = false

func _on_obj_interacted(nome: String) -> void:
	if nome not in aux:
		aux.append(nome)
		num_obj_int += 1
		if len(obj_interacted) == 1:
			obj_interacted.clear()
			obj_interacted.append(nome)
		else:
			obj_interacted.append(nome)

		Dialogic.VAR.set("current_obj", nome)
		if current_day == 1:
			Dialogic.start_timeline("dia_1")
		elif current_day == 2:
			Dialogic.end_timeline()
			Dialogic.start_timeline("dia_3")
		elif current_day == 3:
			Dialogic.end_timeline()
			Dialogic.start_timeline("dia_7")


	elif nome == "bed" and num_obj_int == 5:
		if current_day >= 7:
			print("Final day reached. No further progression.")
			return
		
		current_day += 1
		Dialogic.end_timeline()
		obj_interacted.clear()

		if current_day <= 7:
			_show_day_screen()

func _show_day_screen() -> void:
	day.text = get_day_day_text()
	event_starter.visible = true
	player.global_position = player_start_position
	waiting_for_input = true
	

func get_day_day_text() -> String:
	var day_texts = {
		1: "Day 1",
		2: "Day 3",
		3: "Day 7",
		4: "Day 13",
		5: "Day ??",
		6: "5 Days Later",
		7: "Day ???????"
	}
	return day_texts.get(current_day, "Unknown Day")
