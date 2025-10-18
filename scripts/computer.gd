extends Node3D

var player_in: bool = false

func _process(delta: float) -> void:
	if player_in and Input.is_action_just_pressed("interact"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Globals.player.computer_overlay.visible = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.use_label.visible = true
		player_in = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.use_label.visible = false
		player_in = false
