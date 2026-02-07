extends Area2D

var zone = false
@onready var interact_text: CanvasLayer = %InteractText

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = true
		interact_text.show()
