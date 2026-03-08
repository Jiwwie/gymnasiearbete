extends Node

@onready var player: AudioStreamPlayer = $"AudioStreamPlayer"

# Scenes where music should play (root node names of scenes)
@export var scenes_with_music: Array[String] = [
	"RedButton",
	"Maik1",
	"BadEnding",
	"GoodEnding",
	"SecretEnding"
]

@export var fade_time: float = 1.0  # seconds

# Internal state
var _tween: Tween
var _target_volume_db: float = -10.0
var _last_scene_name: String = ""

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
		_play_music()
	else:
		_stop_music()

func _play_music():
	if _tween:
		_tween.kill()  # cancel any ongoing tween

	if not player.playing:
		player.volume_db = -80
		player.play()

	_tween = create_tween()
	_tween.tween_property(player, "volume_db", _target_volume_db, fade_time) \
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
