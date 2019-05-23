extends Node
#warning-ignore-all:unused_class_variable

var PixelsPerMeter = 26.095
#var PixelsPerMeter = 35.777
var angle_of_tileMap = deg2rad(26.57) # from degrees into radians
var meter2pixel_scalar = cos(angle_of_tileMap)

var Gravity = -9.8 # m/s^2
var AirDensity = 1.21 # kg/m^3


func MeterToPixel(Meters : Vector3) -> Vector3:
	var newX = (Meters.x * PixelsPerMeter) * meter2pixel_scalar
	var newY = - (Meters.x * PixelsPerMeter) * meter2pixel_scalar / 2
	newX += (Meters.y * PixelsPerMeter) * meter2pixel_scalar
	newY +=  (Meters.y * PixelsPerMeter) * meter2pixel_scalar / 2
	var newZ = (Meters.z * PixelsPerMeter)
	return Vector3(newX, newY, newZ)

func PixelToMeter(Pixels: Vector3) -> Vector3:
	return Vector3(0, 0, 0)

# Formula for the Magnus Force is Fm = CoefficientForLift / 2 * SurfaceArea * DensityOfMedium * Velocity^2
# The force is perpindicular to the forward vector; vertical for backspin, downwards for topspin
func CalculateMagnusScalar(LiftCoefficient, SurfaceArea, Velocity):
	pass

# Formula for the Drag Force is Fd = CoefficientForDrag * SurfaceArea * DensityOfMedium * Velocity^2
# The force is always in direct opposition to the forward vector
func CalculateDragScalar(DragCoefficient, SurfaceArea, Velocity):
	pass

