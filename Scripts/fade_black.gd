extends CanvasLayer

@onready var fade_rect = $ColorRect

func fade_to_black():
	fade_rect.modulate.a = 0
	fade_rect.visible = true
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5)
	await tween.finished

func fade_from_black():
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
	await tween.finished
	fade_rect.visible = false
