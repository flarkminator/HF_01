extends Node2D
#warning-ignore-all:unused_class_variable
#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_argument

#warning-ignore:unused_signal
signal serve_ball(location, direction)

var _in_cinematic = false setget set_in_cinematic, get_in_cinematic
onready var TweenNode = $Tween


func _ready():
	pass

func move_by(num_steps : Vector2):
	var current_scene = get_tree().current_scene
	if not current_scene.is_valid_move_on_nav(num_steps):
		return
	else:
		current_scene.move_on_nav(num_steps)
	var new_position
	var xPixels = num_steps.x * Global.PixelsPerTile_x / 2 + num_steps.y * Global.PixelsPerTile_x / 2
	var yPixels = num_steps.y * Global.PixelsPerTile_y / 2 - num_steps.x * Global.PixelsPerTile_y / 2
	new_position = Vector2(position.x + xPixels, position.y + yPixels)

	TweenNode.interpolate_property( self, "position", position, new_position, 0.09, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()
	GM_Match.move_time_forward(0.01) # Does nothing right now


func _physics_update(delta):
	pass

func reset_state():
	print("Ressetting the player to initial state")

func set_in_cinematic(value):
	_in_cinematic = value

func get_in_cinematic():
	return _in_cinematic



