extends "res://utils/state_machine/State.gd"
"""
MOVE STATE - When the player is moving

All state have the following functions:
	func enter():
	func exit():
	func handle_input(event):
	func update(delta):
	func _on_animation_finished(anim_name):
"""


func enter():
	print("MOVE STATE: Enter")


func handle_input(event):
	print("MOVE STATE: input")