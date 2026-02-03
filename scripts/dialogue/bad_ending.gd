extends Node2D

@export var dialogue_system : NodePath
var zone = false
@onready var interact_text: CanvasLayer = %InteractText
var usage = false

func _on_ready() -> void:
	if dialogue_system != null:
		var ds = get_node(dialogue_system)
		ds.start_dialogue()
		ds.show()
		$"DialogueSystem/Base".show()
	else:
		push_error("DialogueSystem not assigned for NPC!")
