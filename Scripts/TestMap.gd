extends Node2D

func _ready():
	print("DragCoefficient:")
	#DragCoefficient, Velocity, AngularVelocity
	var NewDrag = $TennisBall.GetDragCoefficient()
	print(NewDrag)
