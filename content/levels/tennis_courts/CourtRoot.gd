extends Node2D

func _ready():
	var state_machine = $Gameplay_Container/StateMachineTemp
	state_machine.start()
