extends Node2D
#warning-ignore-all:unused_class_variable

var DragCoefficient = 0.55 # Scalar
var mass = 0.055 # kg
var radius = 0.033 # Meters
var circumfrence = 0.003421194 # Meters^2
var is_top_spin := false
var revolutions_per_second = 500.0

var velocity = Vector3(0,0,0)
var acceleration = Vector3(0,0,0)
var polar_pitch = 0
var polar_yaw = 0
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
			velocity = velocity * 0.75
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
	if ball_height > 10:
		$Ball_Regular.frame = 3
	elif ball_height > 5:
		$Ball_Regular.frame = 2
	elif ball_height > 2:
		$Ball_Regular.frame = 1
	else:
		$Ball_Regular.frame = 0


#var launch_vector = Vector3(
#		cos(launch_pitch)*cos(launch_yaw),
#		cos(launch_pitch)*sin(launch_yaw),
#		sin(launch_pitch)
#		) * launch_power

# We update the velocity by a fraction of the acceleration. To do this we have to first calculate the acceleration
# which is based upon the drag forces of the ball in flight. This is determiend by it's angular rotation (lift)
# and by it's current velocity (drag).
func update_velocity(delta_time):
	var square_velocity = velocity.length_squared()
	var drag_scalar = get_drag_coefficient() * circumfrence * Global.AirDensity / 2 * square_velocity
	var lift_scalar = get_lift_coefficient() * circumfrence * Global.AirDensity / 2 * square_velocity
	
	# Computes the polar coordinate angles based upon the current velocity
	calculate_flight_angle()
	
	var drag_angle_pitch = polar_pitch + PI
	var drag_angle_yaw = polar_yaw + PI
	var lift_angle_pitch = (polar_pitch + PI/2) if not is_top_spin else (polar_pitch + PI + PI/2)
	var lift_angle_yaw = 0 #(polar_yaw + PI/2) if not is_top_spin else (polar_yaw + PI + PI/2)
	
	var accelaration_from_drag = Vector3(
			drag_scalar * cos(drag_angle_pitch) + drag_scalar * cos(drag_angle_yaw),
			drag_scalar * sin(drag_angle_yaw),
			drag_scalar * sin(drag_angle_pitch)
			)
	
#	var acceleration = Vector3(
#			drag_scalar * cos(drag_angle) + lift_scalar * cos(lift_angle),     # Acceleration in the X direction (down court)
#			0,     # Y direction
#			drag_scalar * sin(drag_angle) + lift_scalar * sin(lift_angle))     # Z direction (up)
	accelaration_from_drag = accelaration_from_drag / mass
	acceleration = accelaration_from_drag
	acceleration.z = acceleration.z + Global.Gravity
	velocity = velocity + acceleration * delta_time
	if Global.is_vector_close_to_zero(velocity):
		clean_up()



# flight angle = arctan (change in y / change in x)
func calculate_flight_angle():
	if previous_delta.x == 0:
		polar_pitch = PI/2 - atan2(sqrt(pow(velocity.x,2) + pow(velocity.y,2)), velocity.z)
		polar_yaw = atan2(velocity.y, velocity.x)
	else:
		polar_pitch = PI/2 - atan2(sqrt(pow(previous_delta.x,2) + pow(previous_delta.y,2)), previous_delta.z)
		polar_yaw = atan2(previous_delta.y, previous_delta.x)


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