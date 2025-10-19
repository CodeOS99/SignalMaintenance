extends Button

func _on_pressed() -> void:
	#[$"../../WaveMiniGame", $"../../SimonSaysMinigame"].pick_random().visible = true
	$"../../SimonSaysMinigame".visible = true
	$"..".visible = false
