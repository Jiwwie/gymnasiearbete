extends Area2D

@export var target_scene: String
@export var spawn: bool

func _ready() -> void:
	spawn = true
	if Globals.ending == "good":
		target_scene = "good_ending"
	else:
		target_scene = "bad_ending"

func _on_body_entered(body):
	Globals.camera = "normal"
	if body.is_in_group("player"):
		call_deferred("_change_scene")

func _change_scene():
	SceneManager.change_scene(target_scene, spawn)
