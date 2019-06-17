extends Node2D

signal serve_ball(location, direction)

var launch_pitch = deg2rad(20) # Degrees pitch
var launch_yaw = deg2rad(0) # Degrees yaw
var launch_power = 20 # Meters per second
var launch_vector = Vector3(
		cos(launch_pitch)*cos(launch_yaw),
		cos(launch_pitch)*sin(launch_yaw),
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
	if Input.is_action_just_pressed("ui_spawnball"):
		emit_signal("serve_ball", position, launch_vector)

func move_by(num_steps : Vector2):
	var xPixels = num_steps.x * Global.PixelsPerTile_x / 2 + num_steps.y * Global.PixelsPerTile_x / 2
	var yPixels = num_steps.y * Global.PixelsPerTile_y / 2 - num_steps.x * Global.PixelsPerTile_y / 2
	position = Vector2(position.x + xPixels, position.y + yPixels)
	GM_Match.move_time_forward(0.01)
