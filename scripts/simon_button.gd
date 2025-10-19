extends Button

@export var col := "r"

func flash():
	print(":D")
	var t = get_tree().create_tween()
	var ti = .03
	t.tween_property(self, "modulate", Color.WHITE, ti)
	t.tween_property(self, "modulate", Color.DARK_GRAY, ti).set_delay(ti)
	t.tween_callback(func():
		print("finished"))

func _process(delta: float) -> void:
	disabled = not $"..".can_click

func _on_pressed() -> void:
	$"..".user_in += col
