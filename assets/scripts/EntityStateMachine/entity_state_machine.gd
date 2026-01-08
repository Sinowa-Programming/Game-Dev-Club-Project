"""
	An entity state machine holds reference to a CharacterBody3d that will
	be influenced.
"""
class_name EntityStateMachine extends Node

@export var id : String	# The id, so child states can signal the correct state machine
@export var entity : CharacterBody3D 
@export var starting_state: EntityState
 
var states : Dictionary[String, EntityState]
var current_state : EntityState = null

func _ready() -> void:
	# Load all states into the dictionary so they can be looked up based on
	# their IDs. Also disable them.
	for child in get_children():
		if child is EntityState:
			child._setup_state(entity)
			child._disable_state()
			
			states[child.state_id] = child
			child.state_machine_id = id
	
	SignalBus.changed_state.connect(_on_changed_state)
	current_state = starting_state
	_on_changed_state(id, starting_state.state_id)

# This is called by the EntityState's every time
func _on_changed_state(state_machine_id : String, new_state_id : String):
	if id != state_machine_id:
		return
	
	var new_state : EntityState = states[new_state_id]
	
	current_state._disable_state()
	new_state._enable_state()
	
	current_state = new_state
	
	print_debug("%s : New state: %s" % [id, new_state_id])
