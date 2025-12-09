extends Control

@onready var label: Label = $MarginContainer/ColorRect/MarginContainer/Label
@onready var timer: Timer = $MarginContainer/ColorRect/MarginContainer/Timer


func _ready() -> void:
	label.text = ""
	timer.timeout.connect(animate_label)
	
	animate_label()

func animate_label() -> void:
	label.visible_characters += 1
	timer.start()
