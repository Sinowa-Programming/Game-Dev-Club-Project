"""
	This is a global class, named SignalBus.
	It will handle all signals that need to occur though the game.
	To connect to the SignalBus call SignalBus.<signal_name>.connect
	To emit from the SignalBus call SignalBus.<signal_name>.emit
"""
extends Node

# ====STATE MACHINE SIGNALS====
signal changed_state(state_machine_id : String, state_id : String)	# This will be emited every time to change a state
# -----------------------------
