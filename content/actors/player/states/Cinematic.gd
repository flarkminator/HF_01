extends "res://utils/state_machine/State.gd"
"""
CINEMATIC STATE - When the player is locked into a cinematic. Usually used
to block all player input, and have them play a specific animation

All state have the following functions:
	func enter():
	func exit():
	func handle_input(event):
	func update(delta):
	func _on_animation_finished(anim_name):
"""

#warning-ignore:unused_argument
func enter(controller):
#	print("CINEMATIC STATE: Enter")
	pass


#warning-ignore:unused_argument
func handle_input(event):
#	print("CINEMATIC STATE: input")
	pass


func exit():
#	print("CINEMATIC STATE: Exit")
	pass


func update(delta):
	if not get_owner().get_in_cinematic():
		emit_signal("finished", "idle")