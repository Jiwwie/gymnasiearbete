extends Button


func _on_exitgame_pressed() -> void:
	get_tree().quit()


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rooms/house.tscn")
