extends EntityState

var player : Player

func _setup_state(entity : CharacterBody3D) -> void:
	player = entity
	state_id = "Crawling"


func _enable_state() -> void:
	set_process(true)


func _disable_state() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	if not player.is_on_floor():
		SignalBus.changed_state.emit(state_machine_id, "Falling")
	if player.is_on_wall() and player.can_climb:
		SignalBus.changed_state.emit(state_machine_id, "Climbing")
	else:
		pass	#NOTE: I don't see the point of resetting the vertical velocity. They physics engine does this for us
		#vertical_velocity = 0  # Reset the vertical velocity when on the floor
	
	var direction = get_input_direction()
	# Horizontal velocity
	var target_velocity = direction * player.speed
	# Move the character
	player.velocity = target_velocity

# Get normalized input direction
func get_input_direction() -> Vector3:
	var dir = Vector3.ZERO
	if Input.is_action_pressed("Move_Right"):
		dir.x += 1
	if Input.is_action_pressed("Move_Left"):
		dir.x -= 1
	if Input.is_action_pressed("Move_Backward"):
		dir.z += 1
	if Input.is_action_pressed("Move_Forward"):
		dir.z -= 1
	return dir.normalized()
