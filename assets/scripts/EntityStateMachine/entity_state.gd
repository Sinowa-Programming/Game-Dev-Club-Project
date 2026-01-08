class_name EntityState
extends Node

# The name of the state. This is setup if _setup_state
# Used when SignalBus.changed_state.emit( state_machine_id, state_id ) is called.
var state_id : String

# What state machine owns the state so when the signal is called, other state machines ignore it.
# Set externally by the state machine.
var state_machine_id : String

func _setup_state(entity : CharacterBody3D) -> void:
	pass

func _enable_state() -> void:
	pass

func _disable_state() -> void:
	pass
