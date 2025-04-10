extends Control

@onready var buttons = [$StartGame,$QuitGame]
var selected = 0

var controller = false

func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/cutscenes.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
