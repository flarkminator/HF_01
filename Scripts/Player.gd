extends Node2D
#warning-ignore-all:unused_class_variable
#warning-ignore-all:return_value_discarded
#warning-ignore-all:unused_argument

signal serve_ball(location, direction)

var launch_pitch = deg2rad(25) # Degrees pitch
var launch_yaw = deg2rad(5) # Degrees yaw
var launch_power = 20 # Meters per second
var launch_vector = Vector3(
		cos(launch_yaw) * cos(launch_pitch),
		sin(launch_yaw) * cos(launch_pitch),
		sin(launch_pitch)
		) * launch_power

func _ready():
	pass


func _input(event):
	if Input.is_action_just_pressed("ui_up"):
		move_by(Vector2(1, 0))
	if Input.is_action_just_pressed("ui_down"):
		move_by(Vector2(-1, 0))
	if Input.is_action_just_pressed("ui_right"):
		move_by(Vector2(0, 1))
	if Input.is_action_just_pressed("ui_left"):
		move_by(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_accept"):
		pass
	if Input.is_action_just_pressed("ui_spawnball"):
		launch_yaw = deg2rad(rand_range(-5,5))
		launch_pitch = deg2rad(rand_range(10,10))
		launch_power = 30
		var launch_vector = Vector3(
				cos(launch_yaw) * cos(launch_pitch),
				sin(launch_yaw) * cos(launch_pitch),
				sin(launch_pitch)
				) * launch_power
		emit_signal("serve_ball", position, launch_vector)

func move_by(num_steps : Vector2):
	var xPixels = num_steps.x * Global.PixelsPerTile_x / 2 + num_steps.y * Global.PixelsPerTile_x / 2
	var yPixels = num_steps.y * Global.PixelsPerTile_y / 2 - num_steps.x * Global.PixelsPerTile_y / 2
	position = Vector2(position.x + xPixels, position.y + yPixels)
	GM_Match.move_time_forward(0.01)
