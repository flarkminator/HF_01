# This file contains all the logic for the Game Mode: TENNIS MATCH
# It keeps local copies of the active player, the balls that have been spawned, and it is what controls the flow of time in a match.
# Time in this game only moves forward when you take actions (like swinging at the ball, or moving around the court).
# That logic is handled by this game mode.
extends Node
#warning-ignore-all:unused_class_variable
#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_argument

var _tennis_ball_asset = preload("res://Scenes/TennisBall.tscn")
var _tennis_ball = _tennis_ball_asset.instance()
var _player = preload("res://Scenes/Player.tscn").instance()
var _opponent = ""
var _map = ""

var time_step = 0.01 # In seconds


func _ready():
	pass


func get_ball():
	return _tennis_ball_asset.instance()


func get_player():
	return _player


#warning-ignore:unused_argument
func move_time_forward(delta):
	pass


func new_match(level, opponent):
	"""
	This function sets all the local variables, which are used to eventually
	load in the proper assets for this match.
	
	The complication is that 'goto_scene' is a DEFERRED CALL, so we have to
	wait for that root scene to communicate back to this global
	context before we can really begin loading in the court level.	
	"""
	
	# Load the root scene (this should lock the main thread until it's done loading?)
	Global_SceneLoader.goto_scene_path("res://Scenes/Courts/CourtRoot.tscn")
	
	# Set the opponent
	_opponent = opponent
	
	# Set the map to eventually load
	_map = level


func match_loop():
	"""
	First the match plays its intro. Once that is done, it enters the main loop.
	When the match is 'finished' it sets the proper variables and begins the
	end match flow.
	"""
	match_intro()
	print("match loop")
	match_end()


func match_intro():
	print("match intro")


func match_start():
	"""
	The start of a match is where we load in all of the actual assets for this
	match. We can assume the 'root court scene' has already been loaded, as it
	is the one that calls this function.
	A match has a single root scene that is shared by all matches. Under this
	scene we load, as children, the art and gameplay assets. This is done
	because most 'tennis courts' share a bunch of similar gameplay features
	and this allows them all to share a common root scene.
	"""
	
	# Load in the actual art level.
	var current_scene = get_tree().current_scene
	current_scene.add_child_below_node(current_scene.get_node("Level_Container"), load(_map).instance())
	print("match start")
	match_loop()


func match_pause():
	print("match has been paused")


func match_end():
	print("Match end!")