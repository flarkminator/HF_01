extends Node2D

var _nav_mesh_player_position = Vector2(9, 7)
var _nav_mesh_opponent_position = Vector2(5, 5)
var _nav_mesh_length = 9
var _nav_mesh_width = 7
var _nav_mesh_world_position = Vector2(0, 0)

onready var _gameplay_container_node = get_node("Gameplay_Container") setget , get_gameplay_container_node
onready var _spawn_point_node = find_node("SpawnPoint_Player") setget , get_spawn_point_node

func _ready():
	print("CourtRoot: _ready()")
	pass

func get_player_starting_position():
	if is_instance_valid(_spawn_point_node):
		_nav_mesh_world_position = _spawn_point_node.position
	else:
		_spawn_point_node = find_node("SpawnPoint_Player")
		_nav_mesh_world_position = _spawn_point_node.position
	
	return Global.steps_to_pixels(_nav_mesh_player_position, Vector2(_nav_mesh_world_position.x + Global.PixelsPerTile_x / 2, _nav_mesh_world_position.y))

func get_opponent_starting_position():
	pass

func is_valid_move_on_nav(steps : Vector2) -> bool:
	if _nav_mesh_player_position.x + steps.x > _nav_mesh_length or \
	   _nav_mesh_player_position.y + steps.y > _nav_mesh_width or \
	   _nav_mesh_player_position.x + steps.x < 0 or \
	   _nav_mesh_player_position.y + steps.y < 0:
		return false
	return true

func move_on_nav(steps : Vector2):
	_nav_mesh_player_position.x = _nav_mesh_player_position.x + steps.x
	_nav_mesh_player_position.y = _nav_mesh_player_position.y + steps.y

func get_gameplay_container_node() -> Node:
	if not is_instance_valid(_gameplay_container_node):
		_gameplay_container_node = get_node("Gameplay_Container")
	
	return _gameplay_container_node

func get_spawn_point_node() -> Node:
	return _spawn_point_node