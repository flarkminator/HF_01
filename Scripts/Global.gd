extends Node

var PixelsPerMeter = 32

func MeterToPixel(Meters : int) -> int:
	return int(Meters/PixelsPerMeter)

