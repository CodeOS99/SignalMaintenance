extends Control
class_name Knob

@export var min_val: float = 0
@export var max_val: float = 10
@export var randomized: bool = false
@onready var rotator = $Rotator

var following := false

func _ready() -> void:
	if randomized:
		randomize_vals()

func randomize_vals():
	$Rotator.rotation = randf_range(-PI/2, PI/2)

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var mouse_dist_sq = mouse_pos.distance_squared_to(global_position)

	if Input.is_action_just_pressed("click") and mouse_dist_sq <= 16000:
		following = true
	elif Input.is_action_just_released("click"):
		following = false

	if following:
		var ang := global_position.angle_to_point(mouse_pos) + PI/2
		$Rotator.rotation = ang

func get_value():
	return remap($Rotator.rotation, -3.14, 3.14, min_val-2, max_val-2)
