# This file contains all the logic for the Game Mode: TENNIS MATCH
# It keeps local copies of the active player, the balls that have been spawned, and it is what controls the flow of time in a match.
# Time in this game only moves forward when you take actions (like swinging at the ball, or moving around the court).
# That logic is handled by this game mode.
extends Node
#warning-ignore-all:unused_class_variable
#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_argument

# Tennis Ball Variables
var _tennis_ball_asset = preload("res://Scenes/TennisBall.tscn")
var _tennis_ball = _tennis_ball_asset.instance()

# Player Variables
var _player = preload("res://Scenes/Player.tscn").instance()
var _nav_mesh_player_position = Vector2(9, 7)
var _nav_mesh_opponent_position = Vector2(5, 5)
var _nav_mesh_length = 10
var _nav_mesh_width = 8
var _nav_mesh_starting_position = Vector2(0, 0)
var _opponent = ""

# Match Variables
var _root_scene = preload("res://Scenes/Courts/CourtRoot.tscn")
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

	# "goto_scene__" is a deferred function call, so we have no idea when it
	# will actually be called.
	# @see Global_SceneLoader to see where the signal "scene_set_as_current" is sent
	Global_SceneLoader.goto_scene_packed(_root_scene)
	yield(Global_SceneLoader, "scene_set_as_current")
	
	match_load_assets()
	match_loop()


func match_load_assets():
	"""
	This is where we load in all of the actual assets for this
	match. We can assume the 'root court scene' has already been loaded.
	
	A match has a single root scene that is shared by all matches. Under this
	scene we load, as children, the art and gameplay assets. This is done
	because most 'tennis courts' share a bunch of similar gameplay features
	and this allows them all to share a common root scene.
	"""
	
	# Load in the actual art level.
	var current_scene = get_tree().current_scene
	var level_container_node = current_scene.get_node("Level_Container")
	level_container_node.add_child(load(_map).instance())
	
	# Load in the player, and position them onto the "NAV MESH"
	var gameplay_container_node = current_scene.get_node("Gameplay_Container")
	var spawn_point_node = current_scene.find_node("SpawnPoint_Player")
	_nav_mesh_starting_position = spawn_point_node.position
	_player.position = Global.steps_to_pixels(_nav_mesh_player_position, Vector2(_nav_mesh_starting_position.x + Global.PixelsPerTile_x / 2, _nav_mesh_starting_position.y))
#	_player.position = Vector2(_nav_mesh_starting_position.x + Global.PixelsPerTile_x/2, _nav_mesh_starting_position.y)
	gameplay_container_node.add_child(_player)

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

