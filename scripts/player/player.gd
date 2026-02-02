extends CharacterBody2D

var speed = 400
var last_direction = "down"
@onready var cam = $Camera2D
@onready var interact_text: CanvasLayer = %InteractText

func _enter_tree() -> void:
	if SpawnManager.spawn == true:
		SpawnManager.spawn_point = %Spawn
		global_position = SpawnManager.spawn_point.global_position
		
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Globals.is_dialogue_active:
		velocity = Vector2.ZERO
		return
	if Globals.input_locked:
		velocity = Vector2.ZERO
		return
	
	#camera zoom manager
	if Globals.camera == "zoom":
		var tween = create_tween()
		tween.tween_property(cam, "zoom", Vector2(0.5, 0.5), 1.0)
	if Globals.camera == "normal":
		var tween = create_tween()
		tween.tween_property(cam, "zoom", Vector2(1.2, 1.2), 1.0)
	
	if Input.is_action_just_pressed("interact"):
		if interact_text.visible:
			$ClickSound.play()
	
	velocity = Vector2.ZERO
	
	#movement
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
		else:
			$AnimatedSprite2D.animation = "idle"

	if velocity.length() > 0:
		velocity = velocity.normalized()

	velocity = velocity * speed

	move_and_slide()
