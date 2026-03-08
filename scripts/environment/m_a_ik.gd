extends Node2D

@export var projectile_scene: PackedScene
@export var cone_angle: float = 45.0
@export var bullets_per_shot: int = 3

func _ready():
	if has_node("Timer"):
		$Timer.timeout.connect(shoot)

func shoot():
	if projectile_scene == null:
		return

	# 1. FIND THE PLAYER
	# This looks for a node named "player" anywhere in the current scene
	var player = $"../Player"
	
	var base_direction: Vector2
	
	if player:
		# Aim from mAIk's position TOWARDS the player's position
		base_direction = global_position.direction_to(player.global_position)
	else:
		# Fallback to shooting down if player isn't found
		print("Player node not found!")
		base_direction = Vector2.DOWN.rotated(global_rotation)

	var half_angle = deg_to_rad(cone_angle / 2.0)

	for i in bullets_per_shot:
		var bullet = projectile_scene.instantiate()
		
		# Spawn at the NPC's location in the world
		get_tree().current_scene.add_child(bullet)
		bullet.global_position = global_position + (base_direction * 40)
		
		# Apply the random spread to the aim
		var random_angle = randf_range(-half_angle, half_angle)
		var final_direction = base_direction.rotated(random_angle)
		
		bullet.setup(final_direction)
