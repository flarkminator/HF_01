extends Node2D

var DragCoefficient = 0.55 # Scalar
var Mass = 0.055 # kg
var Radius = 0.033 # Meters
var Circumfrence = 0.003421194 # Meters^2
var RevolutionsPerSecond = 500.0

var Velocity = Vector2(30.31088913,17.5)
var Position = Vector2(0,0)

func GetDragCoefficient() -> float:
	return CalculateDragCoefficientForGivenSpeed(Velocity.length())

# The actual drag coefficient for an object is altered by the relationship between it's velocity and angular velocity
func CalculateDragCoefficientForGivenSpeed(Velocity):
	var NewDrag = 0.0
	var AngularVelocity = GetAngularVelocityForRevolutions(RevolutionsPerSecond)
	NewDrag = DragCoefficient + 1 / pow(22.5 + 4.2 * pow(Velocity / AngularVelocity,2.5),0.4)
	return NewDrag

func GetMass() -> float:
	return Mass

func GetRadius() -> float:
	return Radius

func GetCircumfrence() -> float:
	return Circumfrence

# Takes the Revolutions Per Second (in radians) and returns the angular velocity in Meters per Second
func GetAngularVelocityForRevolutions(RevolutionsPerSecond) -> float:
	return (RevolutionsPerSecond * Radius)


func _ready():
	pass
