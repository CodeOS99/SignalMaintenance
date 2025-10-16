extends Node3D

@onready var raycast: RayCast3D = $RayCast3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

var t: Tween

func _ready() -> void:
	_create_tween()

func _create_tween():
	if Globals.has_signal:
		return
	if t:
		t.stop()
	t = get_tree().create_tween()
	t.tween_property(self, "rotation_degrees", Vector3(randi_range(1, 15), randi_range(1, 15), randi_range(1, 15)), 2)
	t.tween_callback(_create_tween)

func _process(delta: float) -> void:
	raycast.force_raycast_update()
	if raycast.is_colliding():
		var point := to_local(raycast.get_collision_point())
		mesh.mesh.height = point.y
		mesh.position.y = point.y/2
		var obj = raycast.get_collider()
		if obj.is_in_group("satellite"):
			Globals.has_signal = true
	
