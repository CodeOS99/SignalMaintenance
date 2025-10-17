extends Node3D

@onready var raycast: RayCast3D = $RayCast3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var t: Tween

func _ready() -> void:
	_create_tween()

func _create_tween():
	if Globals.is_signal:
		print("signal")
		return
	if t:
		t.stop()
	t = get_tree().create_tween()
	t.tween_property(self, "rotation_degrees", Vector3(randi_range(2, 6), randi_range(2, 6), randi_range(2, 6)), 3)
	t.tween_callback(_create_tween)

func _process(delta: float) -> void:
	raycast.force_raycast_update()
	if raycast.is_colliding():
		var point := to_local(raycast.get_collision_point())
		mesh.mesh.height = point.y
		mesh.position.y = point.y/2
		var obj := raycast.get_collider()
		if obj.is_in_group("satellite"):
			Globals.is_signal = true
			$MeshInstance3D.material_override
