extends Node2D

var DragCoefficient = 0.55 # Scalar
var Mass = 0.055 # kg
var Radius = 0.033 # Meters
var Circumfrence = 0.003421194 # Meters^2
var RevolutionsPerSecond = 500.0

var velocity = Vector2(30,0)
var velocity3 = Vector3(5,0,5)
var acceleration = Vector2(0,0)
var ball_height = 0.0
var time_in_air = 0.0
var starting_position

func _ready():
	print("Starting position: (", position.x, ",", position.y, ")")
	starting_position = position

#func _process(delta):
#	var position_delta = Global.MeterToPixel(velocity)
#	velocity3.z = velocity3.z + (Global.Gravity * delta)
#	var position_delta3 = Global.MeterToPixel3(velocity3)
#	position.x = position.x + position_delta.x * delta
#	position.y = position.y + position_delta.y * delta
#	time_in_air += delta
#	SetBallHeight(position_delta3.z)
#
#
#func SetBallHeight(ball_height_delta):
#	ball_height += ball_height_delta
#	$Ball_Regular.position.y = -ball_height
#	if ball_height <= 0:
#		print("Time in the air: ", time_in_air)
#		print("Final position: (", position.x, ",", position.y, ")")
#		print("change position: (", position.x - starting_position.x, ",", position.y - starting_position.y, ")")
#		var change_in_meters = Global.PixelToMeter(Vector2(position.x - starting_position.x, -(position.y - starting_position.y)))
#		print("change in meters: (", change_in_meters.x, ",", change_in_meters.y, ")")
#		queue_free()

# Moves the ball in the world by the number of specified meters. Must be convereted into Pixels.
func move_ball(meters : Vector3):
	var meters_in_pixels = Global.MeterToPixel(meters)
	position.x += meters_in_pixels.x
	position.y += meters_in_pixels.y
	position.y -= meters_in_pixels.z

func GetDragCoefficient() -> float:
	return CalculateDragCoefficientForGivenSpeed(velocity.length())

func GetLiftCoefficient() -> float:
	return CalculateLiftCoefficientForGivenSpeed(velocity.length())

# The actual drag coefficient for an object is altered by the relationship between it's velocity and angular velocity
func CalculateDragCoefficientForGivenSpeed(velocity):
	var NewDrag = 0.0
	var AngularVelocity = GetAngularVelocityForRevolutions(RevolutionsPerSecond)
	NewDrag = DragCoefficient + 1 / pow(22.5 + 4.2 * pow(velocity / AngularVelocity,2.5),0.4)
	return NewDrag

# The Coefficient of Lift is driven by the relationship between velocity and angular velocity
func CalculateLiftCoefficientForGivenSpeed(velocity):
	var NewLift = 0.0
	var AngularVelocity = GetAngularVelocityForRevolutions(RevolutionsPerSecond)
	NewLift = 1 / (2 + velocity / AngularVelocity)
	return NewLift

# Takes the Revolutions Per Second (in radians) and returns the angular velocity in Meters per Second
func GetAngularVelocityForRevolutions(RevolutionsPerSecond) -> float:
	return (RevolutionsPerSecond * Radius)


func GetMass() -> float:
	return Mass


func GetRadius() -> float:
	return Radius


func GetCircumfrence() -> float:
	return Circumfrence

