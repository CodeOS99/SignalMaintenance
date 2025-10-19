extends Control

var resolved := false

func _process(delta: float) -> void:
	mouse_filter = MOUSE_FILTER_IGNORE if not visible else MOUSE_FILTER_STOP
	Engine.time_scale= 0.1 if visible else 1
	$YesSignal.visible = Globals.is_signal
	$NoSignal.visible = not $YesSignal.visible
	if resolved:
		$NoSignal.visible = false
		$YesSignal.visible = false
		$SignalResolved.visible = true
	else:
		$SignalResolved.visible = false
	if $WaveMiniGame.visible or $SimonSaysMinigame.visible:
		$NoSignal.visible = false
		$YesSignal.visible = false
