extends Node2D
#warning-ignore-all:unused_class_variable

var DragCoefficient = 0.55 # Scalar
var mass = 0.055 # kg
var radius = 0.033 # Meters
var circumfrence = 0.003421194 # Meters^2
var is_top_spin := true
var revolutions_per_second = 500.0

var velocity = Vector3(5,0,5)
var acceleration = Vector3(0,0,Global.Gravity)
var previous_delta = Vector3(0,0,0)
var ball_height_offset = -3
var ball_height = 0.0
var time_in_air = 0.0
var starting_position


func _ready():
	print("Starting position: (", position.x, ",", position.y, ")")
	starting_position = position


func _process(delta):
	update_velocity(delta)
	move_ball(delta)
	set_ball_frame()


func clean_up():
	queue_free()


func reset_ball_height_to(new_ball_height):
	ball_height = new_ball_height
	if ball_height < 0:
		ball_height = 0
	
	$Ball_Regular.position.y = ball_height_offset


# Sets the height of the ball above it's shadow, also controls the "size" of the ball as it goes up and down.
# The ball never actually leaves the ground, however. It's faked.
func set_ball_height(ball_height_delta):
	ball_height += ball_height_delta
	if ball_height < 0:
		# Should we bounce?
		if abs(velocity.z) < 0.001: # Slow enough to just stop
			ball_height = 0
		else: # we should bounce
			velocity.z = -velocity.z
			velocity = velocity * 0.5
			ball_height = -ball_height * 0.75


# Moves the ball in the world by the number of specified meters. Must be convereted into Pixels.
# Before it does anything, though, it must see if the ball has bounced.
# If the ball has "bounced" then it adjusts the velocity accordingly.
func move_ball(delta_time):
	previous_delta = velocity * delta_time
	set_ball_height(velocity.z * delta_time)
	var meters_in_pixels = Global.MeterToPixel(velocity)
	position.x += meters_in_pixels.x * delta_time
	position.y += meters_in_pixels.y * delta_time


# Sets the frame of animation for the ball based upon it's height above the court.
# Also sets the height of the "ball" above it's shadow.
func set_ball_frame():
	$Ball_Regular.position.y = - Global.MeterToPixel1(ball_height) + ball_height_offset
	if ball_height > 6:
		$Ball_Regular.frame = 3
	elif ball_height > 4:
		$Ball_Regular.frame = 2
	elif ball_height > 2:
		$Ball_Regular.frame = 1
	else:
		$Ball_Regular.frame = 0


# We update the velocity by a fraction of the acceleration. To do this we have to first calculate the acceleration
# Which is based upon the drag forces of the ball in flight. Which is determiend by it's angular rotation (lift)
# and it's current velocity (drag).
func update_velocity(delta_time):
	var square_velocity = velocity.length_squared()
	var drag_scalar = get_drag_coefficient() * circumfrence * Global.AirDensity / 2 * square_velocity
	var lift_scalar = get_lift_coefficient() * circumfrence * Global.AirDensity / 2 * square_velocity
	var flight_angle = calculate_flight_angle()
	var drag_angle = flight_angle + PI
	var lift_angle = flight_angle + PI/2 if not is_top_spin else flight_angle + PI + PI/2
	var acceleration = Vector3(
			drag_scalar * cos(drag_angle) + lift_scalar * cos(lift_angle),     # Acceleration in the X direction (down court)
			0,     # Y direction
			drag_scalar * sin(drag_angle) + lift_scalar * sin(lift_angle))     # Z direction (up)
	acceleration = acceleration / mass
	acceleration.z = acceleration.z + Global.Gravity
	velocity = velocity + acceleration * delta_time
	if Global.is_vector_close_to_zero(velocity):
		clean_up()


# flight angle = arctan (change in y / change in x)
func calculate_flight_angle():
	var flight_angle = 0
	if previous_delta.x == 0:
		flight_angle = atan(velocity.z / velocity.x)
	else:
		flight_angle = atan(previous_delta.z / previous_delta.x)
	return flight_angle


func get_drag_coefficient() -> float:
	return calculate_dragCoefficient_for_given_speed(velocity.length())


func get_lift_coefficient() -> float:
	return calculate_liftCoefficient_for_given_speed(velocity.length())


# The actual drag coefficient for an object is altered by the relationship between it's velocity and angular velocity
func calculate_dragCoefficient_for_given_speed(velocity):
	var NewDrag = 0.0
	var AngularVelocity = GetAngularVelocityForRevolutions(revolutions_per_second)
	NewDrag = DragCoefficient + 1 / pow(22.5 + 4.2 * pow(velocity / AngularVelocity,2.5),0.4)
	return NewDrag


# The Coefficient of Lift is driven by the relationship between velocity and angular velocity
func calculate_liftCoefficient_for_given_speed(velocity):
	var NewLift = 0.0
	var AngularVelocity = GetAngularVelocityForRevolutions(revolutions_per_second)
	NewLift = 1 / (2 + velocity / AngularVelocity)
	return NewLift


# Takes the Revolutions Per Second (in radians) and returns the angular velocity in Meters per Second
func GetAngularVelocityForRevolutions(revs) -> float:
	return (revs * radius)


func get_mass() -> float:
	return mass


func get_radius() -> float:
	return circumfrence