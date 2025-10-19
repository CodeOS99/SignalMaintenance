extends Label

func _process(delta: float) -> void:
	text = "People Helped: " + str(Globals.people_helped)
