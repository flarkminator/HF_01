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


#warning-ignore:unused_argument
func enter(controller):
#	print("IDLE STATE: Enter")
	pass


func handle_input(event):
#	print("IDLE STATE: input")
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		emit_signal("finished", "move")
		get_tree().set_input_as_handled()


func update(delta):
	pass


func exit():
#	print("IDLE STATE: Exit")
	pass