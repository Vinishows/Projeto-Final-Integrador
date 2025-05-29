extends Area3D

@export var door_id: int

signal door_interacted(door_id: int)

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

var player_in_area = false

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		emit_signal("door_interacted", door_id)
