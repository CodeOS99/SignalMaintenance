extends Control

var A = 1
var phi = 0

var k = 1
var steps = 150

func _process(delta: float) -> void:
	queue_redraw()

func _draw() -> void:
	var width = get_size().x
	var height = get_size().y
	var x_scale = width / steps
	var y_center = height / 2
	var y_scale = 25
	
	A = $"../AKnob".get_value()
	phi = $"../HSlider".value

	for i in range(1, steps):
		draw_line(
			Vector2((i-1) * x_scale, y_center + A * sin(k*i - 0*0 + phi) * y_scale), #0 * 0 for completeness
			Vector2(i * x_scale, y_center + A * sin(k*(i+1) - 0*0 + phi) * y_scale),
			Color(0,1,0)
		)
