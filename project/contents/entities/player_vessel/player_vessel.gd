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
		Signals.emit_signal("rudder_turned", rudder_position, last_rudder_pos)
		last_rudder_pos = rudder_position
	if not is_equal_approx(last_sail_height, sail_height):
		Signals.emit_signal("sail_adjusted", sail_height, last_sail_height)
		last_sail_height = sail_height
	
	## Hack the player to loop around the world
	if global_position.x <= -4900 or global_position.x >= 4900:
		global_position.x *= -1
	if global_position.y <= -3100 or global_position.y >= 3100:
		global_position.y *= -1
	pass


func _unhandled_key_input(event: InputEventKey) -> void:
	if Input.is_action_just_released("pickup"):
		pickup_first()
	if Input.is_action_just_pressed("interact"):
		if open_trade_window():
			stop()
	pass

func open_trade_window() -> bool:
	if _interactables.size() > 0:
		if (_interactables[0] as StaticBuoyantPost).required_items.size() > 0:
			Signals.emit_signal("on_trade_initiated", self, _interactables[0])
			return true
	return false

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
