## Base class for every vessel in the game.
class_name BaseVessel
extends BaseBuoyant

var turn_speed = 15.0
## How fast is it to raise the sail
export var sail_raise_speed := 0.0075
## How fast is it to lower the sail
export var sail_lower_speed := 0.04
## How fast is it to turn the rudder
export var rudder_turn_speed := 0.02

## Current height of the sail.
var sail_height := 0.0 setget set_sail_height
## Current position of the rudder.
var rudder_position := 0.0 setget set_rudder_position


## Safely set sail height (remains within normalized range)
func set_sail_height(value: float) -> void:
	sail_height = clamp(value, 0.0, 1.0)
	pass


## Safely set rudder position (remains within normalized range)
func set_rudder_position(value: float) -> void:
	rudder_position = clamp(value, -1.0, 1.0)
	pass


## Processing of the `BaseVessel`
func _physics_process(delta: float) -> void:
	_process_rudder(delta)
	add_delta_velocity(transform.x * sail_height * 100)
	pass


## Adjust the sail height
func adjust_sails(input: float) -> float:
	var speed := sail_lower_speed
	if input > 0.0:
		speed = sail_raise_speed
	set_sail_height(sail_height + (input * speed))
	return sail_height


## Adjust the rudder.
func adjust_rudder(input: float) -> float:
	set_rudder_position(rudder_position + (input * rudder_turn_speed))
	return rudder_position


func _process_rudder(delta: float) -> void:
	rotate(deg2rad(rudder_position * turn_speed * delta))
	pass
