extends Node
#warning-ignore-all:unused_class_variable
#warning-ignore-all:unused_argument

var PixelsPerTile_x = 64 * 0.625
var PixelsPerTile_y = 32 * 0.625
var PixelsPerMeter = 26.095 * 0.625

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


# Takes in the number of "steps" on the "nav mesh" and converts that into the number of pixels to move.
# Might, later on, convert this into a "path"
func steps_to_pixels(steps : Vector2, offset : Vector2) -> Vector2:
	var newX = steps.x * PixelsPerTile_x / 2
	var newY =  - (steps.x * PixelsPerTile_y) / 2
	newX += steps.y * PixelsPerTile_x / 2
	newY +=  (steps.y * PixelsPerTile_y) / 2
	return Vector2(newX + offset.x, newY + offset.y)

func is_float_close_to_zero(value : float) -> bool:
	return true if value < 0.0001 else false


func is_vector_close_to_zero(values : Vector3) -> bool:
	return true if (is_float_close_to_zero(values.x) && is_float_close_to_zero(values.y) && is_float_close_to_zero(values.z)) else false


func create_2d_array(width, height, value):
	var a = []
	
	for y in range(height):
		a.append([])
		a[y].resize(width)
		for x in range(width):
			a[y][x] = value
	
	return a