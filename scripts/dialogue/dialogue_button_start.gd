extends Button

@export var dialogue_system : NodePath

func _on_pressed() -> void:
	if dialogue_system != null:
			var ds = get_node(dialogue_system)
			ds.start_dialogue()
			ds.show()
			$"../../Scene3".show()
			$"../../Scene3/DialogueSystem/Base".show()
