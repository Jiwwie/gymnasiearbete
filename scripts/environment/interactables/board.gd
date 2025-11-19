extends Area2D

var zone = false
@onready var interact_text: CanvasLayer = %InteractText
@onready var board_ui: CanvasLayer = %BoardUi

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("entered")
		zone = true
		interact_text.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("left")
		zone = false
		interact_text.hide()
		board_ui.hide()
	
func _process(_delta: float) -> void:
	if zone == true and Input.is_action_just_pressed("interact"):
		if board_ui.visible:
			board_ui.hide()
		else:
			board_ui.show()

		
		
