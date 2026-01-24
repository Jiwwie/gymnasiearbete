extends Area2D

@export var dialogue_system : NodePath
var zone = false
@onready var interact_text: CanvasLayer = %InteractText
var usage = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = true
		interact_text.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = false
		interact_text.hide()

func _process(_delta: float) -> void:
	if zone and Input.is_action_just_pressed("interact"):
		if dialogue_system != null:
			var ds = get_node(dialogue_system)
			ds.start_dialogue()
			ds.show()
			$"DialogueSystem/Base".show()
			interact_text.hide()
		else:
			push_error("DialogueSystem not assigned for NPC!")
