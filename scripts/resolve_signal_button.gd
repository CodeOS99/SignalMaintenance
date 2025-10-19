extends Button

func _on_pressed() -> void:
	[$"../../WaveMiniGame", $"../../SimonSaysMinigame"].pick_random().visible = true
	$"..".visible = false
