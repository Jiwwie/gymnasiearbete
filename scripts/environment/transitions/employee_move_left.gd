extends Sprite2D

@onready var employee := $"."
@export var dialogue_system : NodePath
var tween: Tween

func move_left(duration := 0.5, distance := 75.0) -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	
	# Transition the X position relative to where it is now
	var target_x = employee.position.x - distance
	
	tween.tween_property(employee, "position:x", target_x, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	tween.finished.connect(func():
		Globals.input_locked = false
	)


func _on_scene_4_visibility_changed() -> void:
	move_left()
	if dialogue_system != null:
		var ds = get_node(dialogue_system)
		ds.start_dialogue()
		ds.show()
		$"../DialogueSystem/Base".show()
