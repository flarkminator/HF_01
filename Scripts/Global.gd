extends Node
#warning-ignore-all:unused_class_variable

var PixelsPerMeter_Y = 16
var PixelsPerMeter_X = 32

var Gravity = -9.8 # m/s^2
var AirDensity = 1.21 # kg/m^3


func MeterToPixel(X : int, Y : int) -> Array:
	return [int(X/PixelsPerMeter_X), int(Y/PixelsPerMeter_Y)]

# Formula for the Magnus Force is Fm = CoefficientForLift * SurfaceArea * DensityOfMedium * Velocity^2
# The force is perpindicular to the forward vector; vertical for backspin, downwards for topspin
func CalculateMagnusForce():
	pass

# Formula for the Drag Force is Fd = CoefficientForDrag * SurfaceArea * DensityOfMedium * Velocity^2
# The force is always in direct opposition to the forward vector
func CalculateDragForce():
	pass

