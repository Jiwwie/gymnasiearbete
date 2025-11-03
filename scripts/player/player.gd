extends CharacterBody2D

var speed = 400
var last_direction = "down"
#@onready var spawn_point: Marker2D = $"../Spawn"

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if SpawnManager.spawn == true:
		SpawnManager.spawn_point = $"../Spawn"
		player.global_position = SpawnManager.spawn_point.global_position

func _process(_delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		last_direction = "right"
		$AnimatedSprite2D.animation = "walk_side"
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		last_direction = "left"
		$AnimatedSprite2D.animation = "walk_side"
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		last_direction = "up"
		$AnimatedSprite2D.animation = "walk_up"
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		last_direction = "down"
		$AnimatedSprite2D.animation = "walk_down"
		$AnimatedSprite2D.flip_h = false

	if velocity.length() == 0:
		if last_direction == "up":
			$AnimatedSprite2D.animation = "idle_up"
		elif last_direction == "left" or last_direction == "right":
			$AnimatedSprite2D.animation = "idle_side"
		#elif last_direction == "right":
			#$AnimatedSprite2D.animation = "idle_side"
		else:
			$AnimatedSprite2D.animation = "idle"

	if velocity.length() > 0:
		velocity = velocity.normalized()

	velocity = velocity * speed

	move_and_slide()
