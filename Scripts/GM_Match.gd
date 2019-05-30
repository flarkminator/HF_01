# This file contains all the logic for the Game Mode: TENNIS MATCH
# It keeps local copies of the active player, the balls that have been spawned, and it is what controls the flow of time in a match.
# Time in this game only moves forward when you take actions (like swinging at the ball, or moving around the court).
# That logic is handled by this game mode.
extends Node


var _tennis_ball = preload("res://Scenes/TennisBall.tscn").instance()
var _player = preload("res://Scenes/Player.tscn").instance()

var time_step = 0.01 # In seconds



func get_ball():
	return _tennis_ball

func get_player():
	return _player

#warning-ignore:unused_argument
func move_time_forward(delta):
	pass