## Base class for every vessel in the game.
class_name BaseVessel
extends BaseBuoyant

## How fast is it to raise the sail
export var sail_raise_speed := 0.0075
## How fast is it to lower the sail
export var sail_lower_speed := 0.08

onready var aft_position: Position2D = $AftPosition
onready var bow_position: Position2D = $BowPosition

## Current position of the sail (1.0 being full mast, 0.0 fully closed)
var _sail_position := 0.0 setget set_sail_position

## Safely set the sail position (remains in normalized range)
func set_sail_position(value) -> void:
	_sail_position = clamp(value, 0.0, 1.0)
	pass


## Adjusts the sail position
func adjust_sail_position(input: float) -> float:
	var speed = sail_lower_speed
	if input > 0:
		speed = sail_raise_speed
	set_sail_position(_sail_position + (input * speed))
	return _sail_position


## Processing of the `BaseVessel`
func _physics_process(delta: float) -> void:
	add_movement_input(Vector2(0.0, _sail_position))
	print(_sail_position)
	pass
