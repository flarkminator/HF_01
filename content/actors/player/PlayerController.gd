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


#func _input(event):
#	if Input.is_action_just_pressed("ui_accept"):
#		pass
#	if Input.is_action_just_pressed("ui_spawnball"):
#		launch_yaw = deg2rad(rand_range(-5,5))
#		launch_pitch = deg2rad(rand_range(10,10))
#		launch_power = 30
#		var launch_vector = Vector3(
#				cos(launch_yaw) * cos(launch_pitch),
#				sin(launch_yaw) * cos(launch_pitch),
#				sin(launch_pitch)
#				) * launch_power
#		emit_signal("serve_ball", position, launch_vector)


func move_by(num_steps : Vector2):
	var new_position
	var xPixels = num_steps.x * Global.PixelsPerTile_x / 2 + num_steps.y * Global.PixelsPerTile_x / 2
	var yPixels = num_steps.y * Global.PixelsPerTile_y / 2 - num_steps.x * Global.PixelsPerTile_y / 2
	new_position = Vector2(position.x + xPixels, position.y + yPixels)

	TweenNode.interpolate_property( self, "position", position, new_position, 0.09, Tween.TRANS_BACK, Tween.EASE_OUT)
	TweenNode.start()
	GM_Match.move_time_forward(0.01)


func _physics_update(delta):
	pass

func reset_state():
	print("Ressetting the player to initial state")

func set_in_cinematic(value):
	_in_cinematic = value

func get_in_cinematic():
	return _in_cinematic




