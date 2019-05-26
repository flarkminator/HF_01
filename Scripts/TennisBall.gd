extends Node2D

var DragCoefficient = 0.55 # Scalar
var Mass = 0.055 # kg
var Radius = 0.033 # Meters
var Circumfrence = 0.003421194 # Meters^2
var RevolutionsPerSecond = 500.0

var velocity = Vector2(30,0)
var velocity3 = Vector3(5,0,5)
var acceleration = Vector3(0,0,0)
var ball_height_offset = -3
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


# Sets the height of the ball above it's shadow, also controls the "size" of the ball as it goes up and down.
# The ball never actually leaves the ground, however. It's faked.
func set_ball_height(ball_height_delta):
	ball_height += ball_height_delta
	if ball_height < 0:
		ball_height = 0
	
	$Ball_Regular.position.y = - Global.MeterToPixel1(ball_height) + ball_height_offset
	if ball_height > 3:
		$Ball_Regular.frame = 3
	elif ball_height > 2:
		$Ball_Regular.frame = 2
	elif ball_height > 1:
		$Ball_Regular.frame = 1
	else:
		$Ball_Regular.frame = 0


# Moves the ball in the world by the number of specified meters. Must be convereted into Pixels.
func move_ball(meters : Vector3):
	var meters_in_pixels = Global.MeterToPixel(meters)
	position.x += meters_in_pixels.x
	position.y += meters_in_pixels.y
	set_ball_height(meters.z)


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

