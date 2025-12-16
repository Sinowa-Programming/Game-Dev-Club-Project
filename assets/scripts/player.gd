extends CharacterBody3D

# --- Movement settings ---
@export var speed: float = 14
@export var fall_acceleration: float = 75

# --- Climbing settings ---
@export var climb_speed: float = 20  # Default climb speed
var current_climb_speed: float = 0
var can_climb: bool = false

# --- Vertical motion ---
var vertical_velocity: float = 0

# --- Noise system ---
var current_noise_level: float = 0

func _physics_process(delta: float) -> void:
	var direction = get_input_direction()
	
	# Horizontal velocity
	var target_velocity = direction * speed

	# Vertical velocity (falling + climbing)
	vertical_velocity = handle_vertical_movement(delta)
	target_velocity.y = vertical_velocity

	# Move the character
	velocity = target_velocity
	move_and_slide()

	# Noise feedback
	handle_noise(delta)

# --- Get normalized input direction ---
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

# --- Handle vertical movement and climbing ---
func handle_vertical_movement(delta: float) -> float:
	var new_vertical_velocity = vertical_velocity

	# Gravity
	if not is_on_floor():
		new_vertical_velocity -= fall_acceleration * delta
	else:
		new_vertical_velocity = 0

	# Climbing
	if is_on_wall() and can_climb:
		new_vertical_velocity = 0
		if Input.is_action_pressed("Move_Forward"):
			new_vertical_velocity = current_climb_speed * delta
			add_noise(5)
		elif Input.is_action_pressed("Move_Backward"):
			new_vertical_velocity = -current_climb_speed * delta
			add_noise(5)

	return new_vertical_velocity

# --- Noise system ---
func add_noise(amount: float) -> void:
	current_noise_level += amount

func handle_noise(delta: float) -> void:
	if current_noise_level > 0:
		print("Noisy! Current noise level: ", current_noise_level)
		current_noise_level = max(current_noise_level - delta * 2, 0)
