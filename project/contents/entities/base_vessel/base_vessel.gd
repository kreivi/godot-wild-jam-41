## Base class for every vessel in the game.
class_name BaseVessel
extends BaseBuoyant

export var inventory_max_size := 4
export var turn_speed = 15.0
## How fast is it to raise the sail
export var sail_raise_speed := 0.0075
## How fast is it to lower the sail
export var sail_lower_speed := 0.04
## How fast is it to turn the rudder
export var rudder_turn_speed := 0.005
## Maximum angle the rudder sprite will rotate
export var rudder_sprite_max_angle = 30.0

## Current height of the sail.
var sail_height := 0.0 setget set_sail_height
## Current position of the rudder.
var rudder_position := 0.0 setget set_rudder_position

var inventory := []

var _pickupables := []
var _interactables := []

## Reference to the rudder sprite
onready var rudder_sprite: Sprite = $Rudder


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
	add_delta_velocity(transform.x * sail_height * max_speed)
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


func pickup_first() -> bool:
	if _pickupables.size() > 0 && inventory.size() < inventory_max_size:
		var first = _pickupables[0]
		(first as BaseItem).play_pickup_sfx()
		inventory.append(ItemData.get_item_info_for_type((first as BaseItem).type))
		return true
	return false


func remove_item_from_inventory(item) -> void:
	inventory.erase(item)
	pass

func stop() -> void:
	set_sail_height(0.0)
	pass


func _process_rudder(delta: float) -> void:
	if velocity.length() > 0.05:
		rotate(deg2rad(rudder_position * turn_speed * delta))
	rudder_sprite.rotation_degrees = rudder_sprite_max_angle * -rudder_position
	pass


func _toggle_button_prompt(node: Node, toggle: bool) -> bool:
	var ret = false
	if node:
		ret = node.has_method("toggle_button_prompt")
		if ret:
			node.call("toggle_button_prompt", toggle)
		else:
			Logger.warn(str("Couldn't toggle button prompt for: '" + node.name + "'"))
	return ret
	pass

## Callback when body enters pickup range.
func _on_ItemPickupArea_body_entered(body: Node) -> void:
	if body == self:
		return
	if body.is_in_group("item"):
		_toggle_button_prompt(body, true)
		_pickupables.append(body)
	pass


## Callback when body exits pickup range.
func _on_ItemPickupArea_body_exited(body: Node) -> void:
	if body == self:
		return
	_pickupables.erase(body)
	_toggle_button_prompt(body, false)
	pass


func _on_InteractionArea_body_entered(body: Node) -> void:
	if body == self:
		return
	if body.is_in_group("town"):
		_toggle_button_prompt(body, true)
		_interactables.append(body)
	pass


func _on_InteractionArea_body_exited(body: Node) -> void:
	if body == self:
		return
	_interactables.erase(body)
	_toggle_button_prompt(body, false)
	pass

