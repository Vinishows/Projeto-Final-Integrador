extends Area3D

@export var door_id: int
@onready var audio_stream_player_3d: AudioStreamPlayer3D = %AudioStreamPlayer3D

signal door_interacted(door_id: int)

var player_in_area = false

func _on_body_entered(body):
	if body.name == "ProtoController" or "Player_25":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "ProtoController" or "Player_25":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("Interact"):
		emit_signal("door_interacted", door_id)
		audio_stream_player_3d.play()
