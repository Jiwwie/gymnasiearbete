extends CanvasLayer

@onready var rect := $ColorRect
var tween: Tween

func _ready() -> void:
	Globals.input_locked = true

	rect.modulate.a = 1.0
	fade_in(0.5)

func fade_in(duration := 0.5) -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, duration)

	tween.finished.connect(func():
		Globals.input_locked = false
	)
