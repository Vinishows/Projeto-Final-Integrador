extends StaticBody2D

@export var door_id: int
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D

signal door_interacted(door_id: int)

var player_in_area = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		emit_signal("door_interacted", door_id)
		if door_id != 1:
			audio_stream_player_2d.play()
