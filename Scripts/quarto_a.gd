extends Node2D

@onready var day: Label = %day
@onready var event_starter: CanvasLayer = %event_starter
@onready var fade: CanvasLayer = %fade

var go_back = false
var obj_interacted = []
var current_day = 1
var waiting_for_input = true

func _ready():
	_show_day_screen()
	Dialogic.start_timeline("dia 1")

	for obj in get_tree().get_nodes_in_group("objs"):
		obj.obj_interacted.connect(_on_obj_interacted)

func _process(_delta: float) -> void:
	Dialogic.VAR.current_day = current_day
	#Dialogic.VAR.obj_interacted = obj_interacted
	#print(Dialogic.VAR.obj_interacted)
	
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
	if nome not in obj_interacted:
		obj_interacted.append(nome)
		Dialogic.VAR.set_variable("current_obj", nome)
		print(obj_interacted)

	elif nome == "bed" and len(obj_interacted) == 5:
		if current_day >= 7:
			print("Final day reached. No further progression.")
			return
		
		current_day += 1
		obj_interacted.clear()
		print(obj_interacted)
		print(current_day)

		if current_day <= 7:
			_show_day_screen()

func _show_day_screen() -> void:
	day.text = get_day_day_text()
	event_starter.visible = true
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
