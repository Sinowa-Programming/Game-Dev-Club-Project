extends Node3D  # Or StaticBody3D

# Called when a body enters the Area3D
func _on_Area3D_body_entered(body):
	if body.is_in_group("Player"):
		body.can_climb = true  # Change variable in the player
