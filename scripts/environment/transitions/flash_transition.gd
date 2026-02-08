extends CanvasLayer

@onready var rect := $ColorRect
var tween: Tween

func _on_button_pressed() -> void:
	Globals.input_locked = true
	$".".show()
	rect.modulate.a = 1.0
	fade_in(0.5)
	$"../Scene2".show()
	

func fade_in(duration := 0.5) -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, duration)

	tween.finished.connect(func():
		Globals.input_locked = false
	)


func _on_scene_4_visibility_changed() -> void:
	$".".show()
	rect.modulate.a = 1.0
	fade_in(0.5)
