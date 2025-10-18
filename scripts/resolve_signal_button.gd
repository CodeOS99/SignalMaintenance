extends Button

func _on_pressed() -> void:
	$"../../WaveMiniGame".visible = true
	$"..".visible = false
