extends Button

func _on_pressed() -> void:
	Globals.player.computer_overlay.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
