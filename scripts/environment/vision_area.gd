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
	$VisionCone.color = normal_color

func _process(delta):
	if paused:
		return

	rotation += direction * sweep_speed * delta

	if rotation > base_rotation + deg_to_rad(sweep_angle):
		_pause_and_turn(-1)
	elif rotation < base_rotation - deg_to_rad(sweep_angle):
		_pause_and_turn(1)

func _pause_and_turn(new_direction):
	paused = true
	direction = new_direction
	$PauseTimer.start()
	
func alert_on():
	$VisionCone.color = alert_color
	if not $SpotSound.playing:
		$SpotSound.play()

		print("PLAYER SPOTTED")
	# Emit signal / restart level / alert guards
	
func alert_off():
	$VisionCone.color = normal_color


func _on_vision_area_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true
		$DetectionTimer.start()

func _on_vision_area_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false
		$DetectionTimer.stop()
		alert_off()


func _on_detection_timer_timeout():
	if player_inside:
		alert_on()


func _on_pause_timer_timeout():
	paused = false
