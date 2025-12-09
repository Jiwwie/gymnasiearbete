extends Area2D

var zone = false
@onready var interact_text: CanvasLayer = %InteractText
var usage = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and usage == false:
		zone = true
		interact_text.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = false
		interact_text.hide()
	
func _process(_delta: float) -> void:
	if zone == true and Input.is_action_just_pressed("interact"):
		$"../Dialogue/DialogueSystem/Base".show()
		interact_text.hide()
		usage = true
