extends Control

func _process(delta: float) -> void:
	mouse_filter = MOUSE_FILTER_IGNORE if not visible else MOUSE_FILTER_STOP
	$YesSignal.visible = Globals.is_signal
	$NoSignal.visible = not $YesSignal.visible
