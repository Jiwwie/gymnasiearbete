extends Node2D

@export var projectile_scene: PackedScene
@export var cone_angle: float = 45.0
@export var bullets_per_shot: int = 5

func _ready():
	if has_node("Timer"):
		$Timer.timeout.connect(shoot)

func shoot():
	if projectile_scene == null:
		return

	# We change Vector2.RIGHT to Vector2.DOWN to fire downwards
	var base_direction = Vector2.DOWN.rotated(global_rotation)
	var half_angle = deg_to_rad(cone_angle / 2.0)

	for i in bullets_per_shot:
		var bullet = projectile_scene.instantiate()
		
		# Always add child before setting global_position
		get_tree().current_scene.add_child(bullet)
		
		# Spawn offset - moved further down so it doesn't hit mAIk
		bullet.global_position = global_position + (base_direction * 60)
		
		# Calculate random spread within the DOWN cone
		var random_angle = randf_range(-half_angle, half_angle)
		var final_direction = base_direction.rotated(random_angle)
		
		bullet.setup(final_direction)
