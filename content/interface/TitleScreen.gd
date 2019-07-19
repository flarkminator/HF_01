extends Control


func _ready():
	pass

func _on_Button_pressed():
	GM_Match.new_match("res://content/levels/tennis_courts/CourtScene_Grass.tscn", "some opponent")
