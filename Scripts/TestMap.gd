extends Node2D

export (PackedScene) var TennisBall

var active_ball

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_spawnball"):
		spawn_tennis_ball()
	if Input.is_action_just_pressed("ui_up"):
		active_ball.move_ball(Vector3(1.371, 0, 0))
	if Input.is_action_just_pressed("ui_down"):
		active_ball.move_ball(Vector3(-1.371, 0, 0))
	if Input.is_action_just_pressed("ui_right"):
		active_ball.move_ball(Vector3(0, 1.371, 0))
	if Input.is_action_just_pressed("ui_left"):
		active_ball.move_ball(Vector3(0, -1.371, 0))
	if Input.is_action_just_pressed("ui_page_up"):
		active_ball.move_ball(Vector3(0, 0, 1))
	if Input.is_action_just_pressed("ui_page_down"):
		active_ball.move_ball(Vector3(0, 0, -1))

func spawn_tennis_ball():
	active_ball = TennisBall.instance()
	active_ball.position = Vector2(225, 400)
	add_child(active_ball)