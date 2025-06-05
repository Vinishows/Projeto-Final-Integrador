extends Control

@onready var main = $"../."
@onready var resume_game: Button = %ResumeGame
@onready var quit_game: Button = %QuitGame
@onready var buttons = [resume_game,quit_game]
var selected = 0

func _process(delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("down"):
			if selected + 1 < len(buttons):
				selected += 1
		if Input.is_action_just_pressed("up"):
			if selected - 1 >= 0:
				selected -= 1
		if Input.is_action_just_pressed("skip"):
			pass

func _on_resume_game_pressed() -> void:
	main.toggle_pause()

func _on_quit_game_pressed() -> void:
	get_tree().quit()
