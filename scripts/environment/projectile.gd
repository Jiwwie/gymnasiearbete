extends Area2D

@export var speed: float = 300
@export var lifetime: float = 5.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	# Connect collision signal
	if !body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
	
	# Death timer (non-blocking)
	get_tree().create_timer(lifetime).timeout.connect(queue_free)

func setup(dir: Vector2):
	direction = dir.normalized()
	# This sets the visual rotation to match the movement
	rotation = direction.angle()

func _process(delta):
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func _on_body_entered(body):
	# Ignore the player (mAIk)
	if body.is_in_group("player"):
		print("Hit: ", body.name)
		
		if body.has_method("was_hit"):
			body.was_hit()
			
		queue_free()
