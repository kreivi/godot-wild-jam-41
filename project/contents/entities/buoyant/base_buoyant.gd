## Base class for every moving buoyant in the game.
class_name BaseBuoyant
extends KinematicBody2D


## Current velocity
var _velocity := Vector2.ZERO
## Change to the velocity between frames
var _velocity_delta := Vector2.ZERO
## Keeps turn input value stored during one frame.
var _turn_input := 0.0
## Keeps movement input value stored during one frame.
var _movement_input := Vector2.ZERO


## Buoyant processing
func _physics_process(delta: float) -> void:
	_process_turning(delta)
	_process_movement(delta)
	_reset()
	pass


## Adds movement input.
## Returns current value (after adding input) of movement input.
func add_movement_input(input: Vector2) -> Vector2:
	_movement_input += input
	return _movement_input


## Adds turn input for processing.
## Returns current value (after adding input) of turn input.
func add_turn_input(input: float) -> float:
	_turn_input += input
	return _turn_input


## Process buoyant turning.
func _process_turning(delta: float) -> void:
	rotation += _turn_input * delta
	pass


## Process buoyant movement.
func _process_movement(_delta: float) -> void:
	_velocity_delta = _movement_input * _velocity.length()
	_velocity = move_and_slide(_velocity)
	pass


## Resets the between frame variables to default values.
func _reset() -> void:
	_velocity_delta = Vector2.ZERO
	_reset_inputs()
	pass


## Resets input into default values.
func _reset_inputs() -> void:
	_turn_input = 0.0
	_movement_input = Vector2.ZERO
	pass
