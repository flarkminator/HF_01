extends Control

func _ready():
	pass


func _on_Button_pressed():
	GM_Match.match_load("some match", "some opponent")
