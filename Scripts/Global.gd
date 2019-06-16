extends Node
#warning-ignore-all:unused_class_variable
#warning-ignore-all:unused_argument

var PixelsPerTile_x = 64
var PixelsPerTile_y = 32
var PixelsPerMeter = 26.095

var angle_of_tileMap = deg2rad(26.57) # from degrees into radians
var meter2pixel_scalar = cos(angle_of_tileMap)

var Gravity = -9.8 # m/s^2
var AirDensity = 1.21 # kg/m^3

func MeterToPixel1(Meters) -> float:
	return Meters * PixelsPerMeter

func MeterToPixel(Meters : Vector3) -> Vector3:
	var newX = round((Meters.x * PixelsPerMeter) * meter2pixel_scalar)
	var newY =  round(- (Meters.x * PixelsPerMeter) * meter2pixel_scalar / 2)
	newX += round((Meters.y * PixelsPerMeter) * meter2pixel_scalar)
	newY +=  round((Meters.y * PixelsPerMeter) * meter2pixel_scalar / 2)
	var newZ = round(Meters.z * PixelsPerMeter)
	return Vector3(newX, newY, newZ)

func PixelToMeter1(Pixels) -> float:
	return (Pixels / PixelsPerMeter)

# Formula for the Magnus Force is Fm = CoefficientForLift / 2 * SurfaceArea * DensityOfMedium * Velocity^2
# The force is perpindicular to the forward vector; vertical for backspin, downwards for topspin
func CalculateMagnusScalar(LiftCoefficient, SurfaceArea, Velocity):
	pass

# Formula for the Drag Force is Fd = CoefficientForDrag * SurfaceArea * DensityOfMedium * Velocity^2
# The force is always in direct opposition to the forward vector
func CalculateDragScalar(DragCoefficient, SurfaceArea, Velocity):
	pass

func is_float_close_to_zero(value : float) -> bool:
	return true if value < 0.0001 else false

func is_vector_close_to_zero(values : Vector3) -> bool:
	return true if (is_float_close_to_zero(values.x) && is_float_close_to_zero(values.y) && is_float_close_to_zero(values.z)) else false 