extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/rooms/credits.tscn")

func _process(_delta: float) -> void:
	if Globals.close_check == true :
		$"..".show()
