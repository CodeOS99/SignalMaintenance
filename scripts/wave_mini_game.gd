extends Control

var steps := 150
var similarity_threshold := 0.5
var t = 0
var f = 0 # flag

func _process(delta: float) -> void:
	if not Globals.is_signal:
		return
	t += delta
	
	if compare_waves():
		f += 1
	else:
		f = 0
	
	if f >= 10:
		$"../SignalResolved".visible = true
		$".".visible = false
		Globals.is_signal = false
		$"..".resolved = true
		Globals.people_helped += 1
		$AKnob.rotator.rotation = -PI/2
		$OmegaKnob.rotator.rotation = -PI/2
		$PhiSlider.value = 0
		f = 0

func compare_waves():
	var width = get_size().x
	var x_scale = width / steps
	var y_diff_sum := 0.0
	
	for i in range(steps):
		y_diff_sum += abs($TargetWave.displacement(i, t) - $PlayerWave.displacement(i, t))
	
	var avg = y_diff_sum/steps
	return avg <= similarity_threshold
