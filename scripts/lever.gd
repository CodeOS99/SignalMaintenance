extends StaticBody3D

var player_in: bool = false
var is_moving: bool = false
var handle_angle: float = 0.0  # deg

func _process(delta: float) -> void:
	if not is_moving:
		var overlapping_bodies = $Area3D.get_overlapping_bodies()
		var player_found = false

		for body in overlapping_bodies:
			if body.is_in_group("player"):
				player_found = true
				break

		if player_found != player_in:
			player_in = player_found
			Globals.player.use_label.visible = player_in

	is_moving = player_in and Input.is_action_pressed("interact")

	if is_moving:
		var offset_z = -(Globals.player.position.z - self.position.z)
		var target_angle = remap(offset_z, 10, 2, -45, 45)
		handle_angle = lerp_angle(handle_angle, target_angle, delta * 50)  # 5 = speed multiplier
		print(target_angle)
		$handle.rotation_degrees = Vector3(handle_angle, 0, 0)
