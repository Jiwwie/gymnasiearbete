extends Area2D

var zone = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("entered")
		zone = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("left")
		zone = false
	
func _process(_delta: float) -> void:
	if zone == true and Input.is_action_just_pressed("interact"):
		print("interacted")
		
