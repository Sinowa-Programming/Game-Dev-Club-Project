extends EntityState

var player : Player

func _setup_state(entity : CharacterBody3D) -> void:
	player = entity
	state_id = "IDLE"


func _enable_state() -> void:
	set_process(true)


func _disable_state() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	if Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward") != Vector2.ZERO:
		SignalBus.changed_state.emit(state_machine_id, "Crawling")
	
	if not player.is_on_floor():
		SignalBus.changed_state.emit(state_machine_id, "Falling")
		
	player.velocity = Vector3.ZERO
