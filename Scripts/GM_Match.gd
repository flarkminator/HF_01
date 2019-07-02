# This file contains all the logic for the Game Mode: TENNIS MATCH
# It keeps local copies of the active player, the balls that have been spawned, and it is what controls the flow of time in a match.
# Time in this game only moves forward when you take actions (like swinging at the ball, or moving around the court).
# That logic is handled by this game mode.
extends Node

var _tennis_ball_asset = preload("res://Scenes/TennisBall.tscn")
var _map = preload("res://Scenes/TestMap.tscn")
var _tennis_ball = _tennis_ball_asset.instance()
var _player = preload("res://Scenes/Player.tscn").instance()

var time_step = 0.01 # In seconds

func _ready():
	_player.connect("action_menu", self, "_on_Player_action_menu")

func get_ball():
	return _tennis_ball_asset.instance()

func get_player():
	return _player

#warning-ignore:unused_argument
func move_time_forward(delta):
	pass

func _on_Player_action_menu():
	print("Action!")


# Handles all the functionality related to loading into a match, playing it's intro, and capturing
# match relalted events. Also handles pausing the match, when menus popup.
func match_load(level, opponent) -> bool:
	get_tree().change_scene_to(_map)
	return true

func match_intro():
	pass

func match_start():
	pass

func match_loop():
	pass

func match_pause():
	pass

func match_end():
	pass