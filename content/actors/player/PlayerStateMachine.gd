extends "res://utils/state_machine/StateMachine.gd"


func _ready():
	print("PlayerStateMachine._ready()")
	# THE PARENT'S READY IS CALLED FIRST, AUTOMATICALLY
	# So, the TOP child is automatically set as the current state
	# In this case, IDLE
	states_map = {
		'idle': $Idle,
		'move': $Move
	}
	
	for state in get_children():
		state.connect('finished', self, '_change_state')