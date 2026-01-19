extends Area2D

var target_scene = "res://scenes/rooms/headquarters.tscn"

func _ready() -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		call_deferred("_change_scene")
		SpawnManager.spawn = false
		Globals.camera = "zoom"

func _change_scene():
	get_tree().change_scene_to_file(target_scene)
