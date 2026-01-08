extends EntityState

var player : Player

func _setup_state(entity : CharacterBody3D) -> void:
	player = entity
	state_id = "Falling"


func _enable_state() -> void:
	set_process(true)


func _disable_state() -> void:
	set_process(false)


func _process(delta: float) -> void:
	if player.is_on_floor():
		SignalBus.changed_state.emit(state_machine_id, "IDLE")
	
	# Gravity
	player.velocity.y -= player.fall_acceleration * delta
	
