extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("entered")
		if Input.is_action_just_pressed("interact"):
			print("interacted")
