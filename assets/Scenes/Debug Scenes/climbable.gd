extends Node3D  # Or StaticBody3D

@export var climb_speed = 20  # Default climb speed for this wall

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		body.can_climb = true
		body.current_climb_speed = climb_speed  # Send wall-specific speed to player

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		body.can_climb = false
		body.current_climb_speed = 0  # Reset when leaving
