extends Node3D  # Or StaticBody3D

@export var climb_speed = 20  # Default climb speed for this wall
@export var noise_level = 10;
func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		body.can_climb = true
		body.current_climb_speed = climb_speed  # Send wall-specific speed to player
		body.current_noise_level = noise_level

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		body.can_climb = false
		body.current_climb_speed = 0  # Reset when leaving
		body.current_noise_level = 0
