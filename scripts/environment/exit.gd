extends Area2D


var target_scene = "res://scenes/rooms/outside.tscn"
@onready var spawn_point: Marker2D = $Spawn
# @onready var spawn_point = get_tree().get_first_node_in_group("spawn")

func _ready() -> void:
	pass

func _on_body_entered(body):
	if body.is_in_group("player"):
		var player = get_tree().get_first_node_in_group("player")
		get_tree().change_scene_to_file(target_scene)
		player.global_position = spawn_point.global_position
