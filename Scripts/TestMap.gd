extends Node2D

var player
var tennis_ball

func _ready():
	player = GM_Match.get_player()
	player.position = $SpawnPoint_Player.position
	add_child(player)
	player.connect("serve_ball", self, "_on_Player_serve_ball")

func _on_Player_serve_ball(location, direction):
#	print("Yes, receiving serve signal")
#	tennis_ball = GM_Match.get_ball()
#	tennis_ball.position = location
#	tennis_ball.velocity = direction
#	tennis_ball.reset_ball_height_to(direction.y)
#	if not self.has_node("TennisBall"):
#		add_child(tennis_ball)
	
	print("Yes, receiving serve signal")
	var new_tennis_ball = GM_Match.get_ball()
	new_tennis_ball.position = location
	new_tennis_ball.velocity = direction
	new_tennis_ball.reset_ball_height_to(0)
	add_child(new_tennis_ball)

