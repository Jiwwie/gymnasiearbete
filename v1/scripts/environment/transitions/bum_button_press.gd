extends AnimatedSprite2D

@onready var bum := $"." 
@onready var employee := $"../Employee"   # adjust path if needed

var tween: Tween
var employee_fallen := false  # Track if fall finished

func move_up_then_down(duration_up := 0.4, duration_down := 0.2) -> void:
	if tween:
		tween.kill()

	tween = create_tween()
	
	var start_y = bum.position.y
	var up_target = start_y - 80
	var down_target = up_target + 13
	
	# Move up
	tween.tween_property(bum, "position:y", up_target, duration_up) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	
	# Move down
	tween.tween_property(bum, "position:y", down_target, duration_down) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)

	# After bum finishes, fall employee
	tween.finished.connect(_on_bum_finished)

func _on_bum_finished() -> void:
	fall_employee()
	Globals.input_locked = false

func fall_employee() -> void:
	var fall_tween = create_tween()

	var start_pos = employee.position
	var down_target = start_pos.y + 600   # off screen
	var side_target = start_pos.x + 120   # slight arc

	# Fall down
	fall_tween.parallel().tween_property(employee, "position:y", down_target, 0.8) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_IN)

	# Slight sideways arc
	fall_tween.parallel().tween_property(employee, "position:x", side_target, 0.8) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)

	# Rotate forward
	fall_tween.parallel().tween_property(employee, "rotation_degrees", 90, 0.8) \
		.set_trans(Tween.TRANS_QUAD) \
		.set_ease(Tween.EASE_IN)

	# Mark fall finished when done
	fall_tween.finished.connect(_on_employee_fallen)

func _on_employee_fallen() -> void:
	employee_fallen = true
	print("Employee has fallen! Click to continue.")  # debug message

func _process(_delta: float) -> void:
	# Wait for player click after employee fallen
	if employee_fallen and Input.is_action_just_pressed("ui_accept"):
		_go_to_scene_6()

func _go_to_scene_6() -> void:
	$"../../Scene6".show()

func _on_scene_5_visibility_changed() -> void:
	move_up_then_down()
