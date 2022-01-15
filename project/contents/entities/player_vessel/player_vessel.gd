## Player vessel class.
class_name PlayerVessel
extends BaseVessel

## Processing of `PlayerVessel`
func _physics_process(delta: float) -> void:
	add_turn_input(_get_rudder_input())
	adjust_sail_position(_get_sail_input())
	pass


## Clamp input into accepted range.
func _clamp_input(input: float) -> float:
	return clamp(input, -1.0, 1.0)


## Returns rudder (turn) input.
func _get_rudder_input() -> float:
	var input := 0.0
	if Input.is_action_pressed("turn_starboard"):
		input += Input.get_action_strength("turn_starboard")
	if Input.is_action_pressed("turn_port"):
		input -= Input.get_action_strength("turn_port")
	return _clamp_input(input)


## Returns sail (acceleration) input.
func _get_sail_input() -> float:
	var input := 0.0
	if Input.is_action_pressed("raise_sail"):
		input += Input.get_action_strength("raise_sail")
	if Input.is_action_pressed("lower_sail"):
		input -= Input.get_action_strength("lower_sail")
	return _clamp_input(input)
