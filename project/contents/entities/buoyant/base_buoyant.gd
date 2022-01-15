## Base class for every moving buoyant in the game.
class_name BaseBuoyant
extends KinematicBody2D

## What is the maximum speed.
export var max_speed := 30.0
## Linear drag of the buoyant.
export var linear_damp: float = ProjectSettings.get_setting("physics/2d/default_linear_damp")

## Current velocity
var velocity := Vector2.ZERO
## Delta velocity
var delta_velocity := Vector2.ZERO

## Processing of the `BaseBuoyant`
func _physics_process(delta: float) -> void:
	add_delta_velocity(-velocity * linear_damp)
	velocity += delta_velocity
	velocity = move_and_slide(velocity.clamped(max_speed))
	_reset()
	pass


## Adds movement to the buoyant.
func add_delta_velocity(delta: Vector2) -> Vector2:
	delta_velocity += delta
	return delta_velocity


## Reset class variables that must not carry over frames.
func _reset() -> void:
	delta_velocity = Vector2.ZERO
	pass
