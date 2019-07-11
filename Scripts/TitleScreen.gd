extends Control


func _ready():
	pass

func _on_Button_pressed():
	GM_Match.new_match("res://Scenes/Courts/CourtScene_Grass.tscn", "some opponent")
