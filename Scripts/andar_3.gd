extends Node

@export var correct_order: Array[int] = [0, 2, 1] # Exemplo
@export var player_path: NodePath
@export var fade_path: NodePath

var current_step = 0

func _ready():
	for door in get_tree().get_nodes_in_group("doors"):
		door.door_interacted.connect(_on_door_interacted)

func _on_door_interacted(door_id: int):
	if door_id == correct_order[current_step]:
		current_step += 1
		if current_step == correct_order.size():
			print("Level completed!")
			# carregar próxima fase ou tela de vitória
		else:
			await fade_and_teleport()
	else:
		print("Wrong door! Restarting...")
		current_step = 0
		await fade_and_teleport()

func fade_and_teleport():
	var fade = get_node(fade_path)
	var player = get_node(player_path)
	await fade.fade_to_black()
	player.global_position = Vector3(9.3, 0.497, 10.138)
	await fade.fade_from_black()
