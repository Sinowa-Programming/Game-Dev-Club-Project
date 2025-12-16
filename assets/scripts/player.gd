extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# Climbing speed when touching a wall
@export var climb_speed = 20
var current_climb_speed = 0
var can_climb = false
# Variable to store vertical velocity
var vertical_velocity = 0
# Will cause noise by other things, like climbing and rustling
var current_noise_level = 0;
func _physics_process(delta):
	# Create a local variable to store the input direction.
	var direction = Vector3.ZERO
	if current_noise_level > 0:
		print("Noisy! Your noise is: ")
		print(current_noise_level)
	# Check for each move input and update the direction accordingly.
	if Input.is_action_pressed("Move_Right"):
		direction.x += 1
	if Input.is_action_pressed("Move_Left"):
		direction.x -= 1
	if Input.is_action_pressed("Move_Backward"):
		direction.z += 1
	if Input.is_action_pressed("Move_Forward"):
		direction.z -= 1

	# Normalize the direction vector to ensure consistent speed when moving diagonally.
	direction = direction.normalized()

	# Calculate the target velocity based on input direction and speed.
	var target_velocity = direction * speed

	# Manage vertical velocity for falling
	if not is_on_floor():
		vertical_velocity -= fall_acceleration * delta  # Apply falling acceleration
	else:
		vertical_velocity = 0  # Reset the vertical velocity when on the floor

	# Handling climbing when touching a wall
	if is_on_wall():
		if can_climb:
			if Input.is_action_pressed("Move_Forward"):
				vertical_velocity = current_climb_speed * delta  # Use wall-specific speed
			elif Input.is_action_pressed("Move_Backward"):
				vertical_velocity = -current_climb_speed * delta  # Optionally move down

	# Assign vertical velocity to target_velocity
	target_velocity.y = vertical_velocity  # Update vertical velocity in target_velocity

	# Move the character.
	velocity = target_velocity  # Assign the target velocity to the character's velocity
	move_and_slide()  # Call move_and_slide with the correct velocity
