extends Node2D

@export_group("Sweep")
@export var sweep_angle := 60.0
@export var sweep_speed := 1.5
@export var pause_time := 0.6

@export_group("Detection")
@export var detection_delay := 1.0

@export_group("Visuals")
@export var normal_color := Color(1, 1, 0, 0.25)
@export var alert_color := Color(1, 0, 0, 0.35)

var direction := 1
var base_rotation := 0.0
var paused := false
var player_inside := false


func _ready():
	base_rotation = rotation

func _process(delta):
	if paused:
		return

	rotation += direction * sweep_speed * delta

	var max_rot = base_rotation + deg_to_rad(sweep_angle)
	var min_rot = base_rotation - deg_to_rad(sweep_angle)

	if rotation >= max_rot:
		rotation = max_rot
		direction = -1
		pause_at_edge()

	elif rotation <= min_rot:
		rotation = min_rot
		direction = 1
		pause_at_edge()

func pause_at_edge():
	paused = true
	await get_tree().create_timer(pause_time).timeout
	paused = false

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player spotted!")
		# trigger alarm, restart, etc.
