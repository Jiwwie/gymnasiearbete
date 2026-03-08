extends Button

# Export options
@export var target_scene: PackedScene       # assign a scene if you want to change scene
@export var target_node: NodePath           # assign a node to show/hide in current scene
@export var hide_on_start: bool = false     # hide the node initially if desired

func _ready() -> void:
	if hide_on_start and target_node != null:
		var node = get_node_or_null(target_node)
		if node:
			node.visible = false
	
	# Connect button press
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# If a scene is assigned, change to it
	if target_scene != null:
		get_tree().change_scene_to_packed(target_scene)
		return

	# Otherwise, show the node
	if target_node != null:
		var node = get_node_or_null(target_node)
		if node:
			node.visible = true
