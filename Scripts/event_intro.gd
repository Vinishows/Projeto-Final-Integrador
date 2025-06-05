extends Control

@onready var label: Label = %Label
@export var texto_do_dia: String = "Dia 1"
@export var duracao: float = 2.0 # segundos até desaparecer

func _ready():
	label.text = texto_do_dia
	await get_tree().create_timer(duracao).timeout
	queue_free()
