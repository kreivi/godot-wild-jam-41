## Player vessel class.
class_name PlayerVessel
extends BaseVessel

## Keep rudder position stored so we don't spam the signal unnecessarily
var last_rudder_pos := rudder_position
## Keep sail height stored so we don't spam the signal unnecessarily
var last_sail_height := sail_height

## Processing of `PlayerVessel`
func _physics_process(_delta: float) -> void:
	adjust_rudder(_get_rudder_input())
	adjust_sails(_get_sail_input())
	if not is_equal_approx(last_rudder_pos, rudder_position):
		last_rudder_pos = rudder_position
		Signals.emit_signal("rudder_turned", last_rudder_pos)
	if not is_equal_approx(last_sail_height, sail_height):
		last_sail_height = sail_height
		Signals.emit_signal("sail_adjusted", last_sail_height)
	pass


func _unhandled_key_input(event: InputEventKey) -> void:
	if Input.is_action_just_released("pickup"):
		pickup_first()
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
