extends Node

@onready var player: AudioStreamPlayer = $"AudioStreamPlayer"

# Scenes where music should play (root node names of scenes)
@export var scenes_with_music: Array[String] = [
	"Outside",
	"Forest",
    "Headquarters"
]

@export var fade_time: float = 1.0  # seconds

# Internal state
var _tween: Tween
var _last_scene_name: String = ""
var _default_volume_db: float = -5  # normal volume
var _headquarters_volume_db: float = -22.0  # quieter in Headquarters

func _ready():
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	var current_scene = get_tree().current_scene
	if current_scene:
		_last_scene_name = current_scene.name
		_check_music_for_scene(_last_scene_name)

func _process(_delta: float) -> void:
	var current_scene = get_tree().current_scene
	if current_scene:
		var scene_name = current_scene.name
		if scene_name != _last_scene_name:
			_last_scene_name = scene_name
			_check_music_for_scene(scene_name)

func _check_music_for_scene(scene_name: String) -> void:
	if scene_name in scenes_with_music:
		_play_music(scene_name)
	else:
		_stop_music()

func _play_music(scene_name: String):
	if _tween:
		_tween.kill()  # cancel any ongoing tween

	if not player.playing:
		player.volume_db = -80
		player.play()

	# Set target volume depending on the scene
	var target_volume = _default_volume_db
	if scene_name == "Headquarters":
		target_volume = _headquarters_volume_db

	_tween = create_tween()
	_tween.tween_property(player, "volume_db", target_volume, fade_time) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)

func _stop_music():
	if _tween:
		_tween.kill()  # cancel any ongoing tween

	_tween = create_tween()
	_tween.tween_property(player, "volume_db", -80, fade_time) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN_OUT)
	
	# Stop the player after fade completes
	_tween.tween_callback(Callable(player, "stop"))
