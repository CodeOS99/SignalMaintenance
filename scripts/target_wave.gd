extends Control

var A = 1
var k = 1
var t = 0
var omega = 1
var phi = 0
var steps = 150

func _process(delta: float) -> void:
	t += delta
	queue_redraw()

func _draw() -> void:
	var width = get_size().x
	var height = get_size().y
	var x_scale = width / steps
	var y_center = height / 2
	var y_scale = 25

	for i in range(1, steps):
		draw_line(
			Vector2((i-1) * x_scale, y_center + A * sin(k*i - omega*t + phi) * y_scale),
			Vector2(i * x_scale, y_center + A * sin(k*(i+1) - omega*t + phi) * y_scale),
			Color(1,1,1)
		)

func displacement(x, t_):
	if t_ == null:
		t_ = t
	return A * sin(k*x - omega * t + phi)
