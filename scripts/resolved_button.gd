extends Button

func _on_pressed() -> void:
	Globals.player.computer_overlay.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals._signal._create_tween()
	Globals._signal.rotate_randomly()
	Globals.is_signal = false
