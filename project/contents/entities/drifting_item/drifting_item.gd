class_name DriftingItem
extends BaseItem

var _constant_velocity := Vector2.ZERO

func _ready() -> void:
	_constant_velocity = Vector2(rand_range(1.0, max_speed), rand_range(1.0, max_speed))
	pass

func _physics_process(delta: float) -> void:
	add_delta_velocity(_constant_velocity)
	look_at(global_position + _constant_velocity)
	pass
