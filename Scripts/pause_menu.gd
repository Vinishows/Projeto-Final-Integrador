extends Control

@onready var main = $"../."
@onready var buttons = [$ResumeGame,$QuitGame]
var selected = 0

func _process(delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("down"):
			if selected + 1 < len(buttons):
				selected += 1
				focus_bt(selected)
		if Input.is_action_just_pressed("up"):
			if selected - 1 >= 0:
				selected -= 1
				focus_bt(selected)
		if Input.is_action_just_pressed("skip"):
			select_bt()

func _on_resume_game_pressed() -> void:
	main.toggle_pause()

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_visibility_changed() -> void:
	if visible:
		focus_bt(0)

func focus_bt(bt):
	for i in range(len(buttons)):
		if bt == i:
			buttons[i].button_pressed = true
		else:
			buttons[i].button_pressed = false

func select_bt():
	for i in range(len(buttons)):
		if buttons[i].button_pressed:
			buttons[i].emit_signal("pressed")
