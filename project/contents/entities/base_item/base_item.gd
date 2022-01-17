class_name BaseItem
extends BaseBuoyant

onready var _pickup_prompt := $PickupPrompt

func _physics_process(_delta: float) -> void:
	if _pickup_prompt:
		_pickup_prompt.global_rotation_degrees = 0
	pass


func toggle_pickup_prompt(toggle: bool) -> void:
	if _pickup_prompt:
		_pickup_prompt.visible = toggle
	pass
