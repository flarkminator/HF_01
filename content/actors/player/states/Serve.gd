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
var timer = 0


#warning-ignore:unused_argument
func enter(controller):
	var launch_pitch = deg2rad(25) # Degrees pitch
	var launch_yaw = deg2rad(5) # Degrees yaw
	var launch_power = 20 # Meters per second
	var launch_vector = Vector3(
		cos(launch_yaw) * cos(launch_pitch),
		sin(launch_yaw) * cos(launch_pitch),
		sin(launch_pitch)
		) * launch_power
	
	get_tree().current_scene.serve_ball(get_owner().position, launch_vector)

func handle_input(event):
	pass

func update(delta):
	if timer < 0.1:
		timer += delta
	else:
		emit_signal("finished", "idle")


func exit():
#	print("IDLE STATE: Exit")
	pass