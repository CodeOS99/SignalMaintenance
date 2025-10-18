extends Control

var steps := 150
var similarity_threshold := 0.2
var t = 0
var f = 0 # flag

func _process(delta: float) -> void:
	t += delta
	
	if compare_waves():
		f += 1
	else:
		f = 0
	
	if f >= 10:
		print(true)

func compare_waves():
	var width = get_size().x
	var x_scale = width / steps
	var y_diff_sum := 0.0
	
	for i in range(steps):
		y_diff_sum += abs($TargetWave.displacement(i, t) - $PlayerWave.displacement(i, t))
	
	var avg = y_diff_sum/steps
	return avg <= similarity_threshold
