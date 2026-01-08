extends EntityState

#TODO: Update this when the "Climbing Area" scaling is fixed
const RAY_LENGTH : float = 40
const CLIMB_OVER_DISTANCE : float = 1.05	# How far forward the player will be teleported after the climb is complete

var player : Player

func _setup_state(entity : CharacterBody3D) -> void:
	player = entity
	state_id = "Climbing"


func _enable_state() -> void:
	set_process(true)


func _disable_state() -> void:
	set_process(false)


func _process(delta: float) -> void:
	# Climbing
	var new_vertical_velocity : Vector3 = Vector3.ZERO# Zero out the other two directions to avoid residual velocity.
	if Input.is_action_pressed("Move_Forward"):
		new_vertical_velocity.y = player.current_climb_speed * delta
		player.add_noise(5)
	elif Input.is_action_pressed("Move_Backward"):
		new_vertical_velocity.y = -player.current_climb_speed * delta
		player.add_noise(5)
	
	player.velocity = new_vertical_velocity
	
	# If after the move, the player is on the floor and is trying to climb down
	if not player.can_climb or new_vertical_velocity.y < 0 and player.is_on_floor():
		climb_over()
		SignalBus.changed_state.emit(state_machine_id, "IDLE")

# Shift the player model so it is on top of the object is has climbed
func climb_over() -> void:
	var ray_start_pos : Vector3 = player.position
	var ray_direction : Vector3 = Vector3.DOWN
	
	ray_start_pos.z -= CLIMB_OVER_DISTANCE
	
	# Raycast query the distance in front of the character to find the new floor
	var space_state = player.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start_pos, ray_start_pos + (ray_direction * RAY_LENGTH),
		player.collision_mask, [player])
		
	var result = space_state.intersect_ray(query)
	if result:
		player.position = result.position
		
