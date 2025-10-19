extends Button
signal finished_flash

@export var col := "r"

func flash():
	var t = get_tree().create_tween()
	var ti = .03
	t.tween_property(self, "modulate", Color.WHITE, ti)
	t.tween_property(self, "modulate", Color(.274, .274, .274), ti).set_delay(ti)
	t.tween_callback(func():
		finished_flash.emit())

func _process(delta: float) -> void:
	disabled = not $"../..".can_click

func _on_pressed() -> void:
	$"../..".add(col)
