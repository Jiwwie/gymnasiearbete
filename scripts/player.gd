extends CharacterBody2D

var speed = 400

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		velocity.x += speed*delta
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed*delta
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed*delta
	if Input.is_action_pressed("move_down"):
		velocity.y += speed*delta
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	move_and_slide()
