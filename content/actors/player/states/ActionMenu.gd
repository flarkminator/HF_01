extends "res://utils/state_machine/State.gd"
"""
ACTION MENU STATE - When the player opens their action menu, which is used for
hitting the ball, or using special moves.

IN this state all input commands no longer move the player, but interact with
the UI

All state have the following functions:
	func enter():
	func exit():
	func handle_input(event):
	func update(delta):
	func _on_animation_finished(anim_name):
"""

#warning-ignore:unused_argument
func enter(controller):
	print("ACTION MENU STATE: Enter")


#warning-ignore:unused_argument
func handle_input(event):
	print("ACTION MENU STATE: input")


func exit():
	print("ACTION MENU STATE: Exit")