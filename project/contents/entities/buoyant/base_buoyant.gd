## Base class for every moving buoyant in the game.
class_name BaseBuoyant
extends KinematicBody2D

## What is the maximum speed.
export var max_speed := 60.0
## Linear drag of the buoyant.
export var linear_damp: float = ProjectSettings.get_setting("physics/2d/default_linear_damp")

## Current velocity
var velocity := Vector2.ZERO
## Delta velocity
var delta_velocity := Vector2.ZERO

#onready var _trail := $Trail
onready var _trail_start_pos := $TrailStartPos


## Processing of the `BaseBuoyant`
func _physics_process(delta: float) -> void:
	add_delta_velocity(-velocity * linear_damp)
	velocity += delta_velocity
	velocity = move_and_slide(velocity.clamped(max_speed))
	_reset()
#	_trail.add_point(_trail_start_pos.global_position)
	pass


## Adds movement to the buoyant.
func add_delta_velocity(delta: Vector2) -> Vector2:
	delta_velocity += delta
	return delta_velocity


## Reset class variables that must not carry over frames.
func _reset() -> void:
	delta_velocity = Vector2.ZERO
	pass
