extends Control

@onready var start_game: Button = %StartGame
@onready var quit_game: Button = %QuitGame

@onready var buttons = [start_game,quit_game]
var selected = 0

var controller = false

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/quarto_a.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
