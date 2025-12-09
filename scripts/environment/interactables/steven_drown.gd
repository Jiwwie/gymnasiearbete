extends Area2D

var zone = false
@onready var interact_text: CanvasLayer = %InteractText

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = true
		interact_text.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = false
		interact_text.hide()
	
func _process(_delta: float) -> void:
	pass
