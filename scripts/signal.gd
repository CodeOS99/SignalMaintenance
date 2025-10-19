class_name _Signal extends Node3D

@onready var raycast: RayCast3D = $RayCast3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var t: Tween

func _ready() -> void:
	Globals._signal = self
	_create_tween()

func _create_tween():
	if t:
		t.stop()
	t = get_tree().create_tween()
	t.tween_property(self, "rotation_degrees", Vector3(randi_range(-8, 8), randi_range(-8, 8), randi_range(-8, 8)), 4)
	t.tween_callback(_create_tween)

func rotate_randomly():
	rotation_degrees = Vector3(randf_range(3, 6), randf_range(3, 6), randf_range(3, 6))

func _process(delta: float) -> void:
	raycast.force_raycast_update()
	var target_y = -28.3
	if raycast.is_colliding():
		var point := to_local(raycast.get_collision_point())
		target_y = point.y
		var obj := raycast.get_collider()
		if obj.is_in_group("satellite"):
			Globals.is_signal = true
	if Globals.is_signal:
		var mat = mesh.material_override
		var green_color = Color(0, 1, 0, .8078)
		mat.albedo_color = green_color
		mat.emission_enabled = true
		mat.emission = green_color
		mat.emission_energy_multiplier = 10.0
	else:
		var mat = mesh.material_override
		var purp_color = Color(1, 0, 1, .8078)
		mat.albedo_color = purp_color
		mat.emission_enabled = true
		mat.emission = Color(1, 0, 187/255, .8078)
		mat.emission_energy_multiplier = 10.0


	mesh.mesh.height = target_y
	mesh.position.y = target_y/2
