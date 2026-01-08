class_name Player
extends CharacterBody3D

# --- Movement settings ---
@export var speed: float = 14
@export var fall_acceleration: float = 75

# --- Climbing settings ---
@export var climb_speed: float = 20  # Default climb speed
var current_climb_speed: float = 0
var can_climb: bool = false

# --- Noise system ---
var current_noise_level: float = 0

func _physics_process(delta: float) -> void:
	move_and_slide()	# All of the changes happen in the state. This just updates if changes has occured

	# Noise feedback
	handle_noise(delta)

# --- Noise system ---
func add_noise(amount: float) -> void:
	current_noise_level += amount

func handle_noise(delta: float) -> void:
	if current_noise_level > 0:
		#print("Noisy! Current noise level: ", current_noise_level)	#NOTE: Commented out due to 
		current_noise_level = max(current_noise_level - delta * 2, 0)
