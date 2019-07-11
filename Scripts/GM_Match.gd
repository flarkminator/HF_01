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
var _root_scene = preload("res://Scenes/Courts/CourtRoot.tscn")
var _opponent = ""
var _map = ""
var _match_done = false

var time_step = 0.01 # In seconds

signal match_intro_finished()

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
	
	# Set local variables
	_opponent = opponent
	_map = level
	_match_done = false

	# Request the root scene to be loaded, and then wait for it to be loaded
	Global_SceneLoader.goto_scene_packed(_root_scene)
	yield(Global_SceneLoader, "scene_set_as_current")
	
	match_load_assets()
	match_loop()


func match_load_assets():
	"""
	This is where we load in all of the actual assets for this
	match. We can assume the 'root court scene' has already been loaded, as it
	is the one that calls this function.
	A match has a single root scene that is shared by all matches. Under this
	scene we load, as children, the art and gameplay assets. This is done
	because most 'tennis courts' share a bunch of similar gameplay features
	and this allows them all to share a common root scene.
	"""
	
	# Load in the actual art level.
	var level_container_node = get_tree().current_scene.get_node("Level_Container")
	level_container_node.add_child(load(_map).instance())
	print("match assets loaded")


func match_loop():
	"""
	First the match plays its intro. Once that is done, it enters the main loop.
	When the match is 'finished' it sets the proper variables and begins the
	end match flow.
	"""
	match_intro()
	
	yield(self, "match_intro_finished")
	while not _match_done:
		print("match loop")
		yield(get_tree().create_timer(5.0), "timeout")
		print("match loop")
		_match_done = true
	
	match_end()


func match_intro():
	print("match intro start")
	var AnimPlayer = get_tree().current_scene.find_node("AnimationPlayer_ScreenFade")
	AnimPlayer.play("Fade")
	yield(AnimPlayer, "animation_finished")
	print("match intro done")
	emit_signal("match_intro_finished")


func match_pause():
	print("match has been paused")


func match_end():
	print("Match end!")