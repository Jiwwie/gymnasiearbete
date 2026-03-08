extends PointLight2D

func _ready():
	var tween = create_tween().set_loops()
	
	tween.tween_property(self, "energy", 2.0, 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "energy", 0.1, 0.5).set_trans(Tween.TRANS_SINE)
