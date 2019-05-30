extends Node2D

signal serve_ball(location, direction)

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
		emit_signal("serve_ball", position, Vector3(5, 0, 5))

func move_by(num_steps : Vector2):
	var xPixels = num_steps.x * Global.PixelsPerTile_x / 2 + num_steps.y * Global.PixelsPerTile_x / 2
	var yPixels = num_steps.y * Global.PixelsPerTile_y / 2 - num_steps.x * Global.PixelsPerTile_y / 2
	position = Vector2(position.x + xPixels, position.y + yPixels)
