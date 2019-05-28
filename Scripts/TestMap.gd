extends Node2D

export (PackedScene) var TennisBall

var active_ball

func _ready():
	pass

func spawn_tennis_ball():
	var starting_position = Global.MeterToPixel(Vector3(-9 * 1.371, 17 * 1.371, 0))
	active_ball = TennisBall.instance()
#	active_ball.position = Vector2(225, 400)
	active_ball.position = Vector2(starting_position.x, starting_position.y - 16)
	add_child(active_ball)