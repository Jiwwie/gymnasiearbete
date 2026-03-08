extends Area2D

var zone = false
@onready var interact_text: CanvasLayer = %InteractText
@export var target_scene: String
@export var spawn: bool

func _ready() -> void:
	spawn = true
	if Globals.ending == "good":
		target_scene = "good_ending"
	else:
		target_scene = "bad_ending"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		zone = true
		interact_text.show()	

func _process(_delta: float) -> void:
	if zone == true and Input.is_action_just_pressed("interact"):
		call_deferred("_change_scene")

func _change_scene():
	SceneManager.change_scene(target_scene, spawn)
	
	
