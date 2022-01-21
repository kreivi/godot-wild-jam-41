class_name BaseItem
extends BaseBuoyant

enum ITEM_TYPES { UNKNOWN, BARREL, WOOD, PLASTIC}

onready var _button_prompt := $PickupPrompt

func _physics_process(_delta: float) -> void:
	if _button_prompt:
		_button_prompt.global_rotation_degrees = 0
	pass


func toggle_button_prompt(toggle: bool) -> void:
	if _button_prompt:
		_button_prompt.visible = toggle
	pass


## Virtual function returns item information
func get_item_info() -> Dictionary:
	return {
		"type": ITEM_TYPES.UNKNOWN,
		"img": "",
	}
