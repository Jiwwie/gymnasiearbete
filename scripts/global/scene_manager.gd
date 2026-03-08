extends Node

func change_scene(target_scene: String, spawn: bool) -> void:
	SpawnManager.spawn = spawn
	get_tree().change_scene_to_file("res://scenes/rooms/" + target_scene + ".tscn")
