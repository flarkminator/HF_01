extends "res://utils/state_machine/State.gd"
"""
IDLE STATE - When the player is waiting for input.

All state have the following functions:
	func enter():
	func exit():
	func handle_input(event):
	func update(delta):
	func _on_animation_finished(anim_name):
"""


func enter():
	print("IDLE STATE: Enter")


func handle_input(event):
	print("IDLE STATE: input")


func exit():
	print("IDLE STATE: Exit")