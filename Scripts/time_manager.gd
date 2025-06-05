extends Node

var dia_atual = 1
const QUARTO_A = preload("res://Scenes/quarto_a.tscn")
const EVENT_INTRO = preload("res://Scenes/event_intro.tscn")

func _ready():
	mostrar_intro("Dia 1")
	carregar_quarto()

func mostrar_intro(texto):
	var intro = EVENT_INTRO.instantiate()
	intro.texto_do_dia = texto
	add_child(intro) 

func carregar_quarto():
	var quarto = QUARTO_A.instantiate()
	add_child(quarto)
	quarto.connect("exploracao_finalizada", Callable(self, "_on_exploracao_finalizada"))

func _on_exploracao_finalizada():
	dia_atual += 2
	mostrar_intro("Dia %d" % dia_atual)
