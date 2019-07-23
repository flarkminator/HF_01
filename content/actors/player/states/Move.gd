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
var timer = 0


func enter(controller):
#	print("MOVE STATE: Enter")
	
	timer = 0
	if Input.is_action_just_pressed("ui_up"):
		controller.move_by(Vector2(1, 0))
	if Input.is_action_just_pressed("ui_down"):
		controller.move_by(Vector2(-1, 0))
	if Input.is_action_just_pressed("ui_right"):
		controller.move_by(Vector2(0, 1))
	if Input.is_action_just_pressed("ui_left"):
		controller.move_by(Vector2(0, -1))


#warning-ignore:unused_argument
func handle_input(event):
#	print("MOVE STATE: input")
	pass


func update(delta):
	if timer < 0.1:
		timer += delta
	else:
		emit_signal("finished", "idle")


func exit():
#	print("MOVE STATE: Exit")
	pass