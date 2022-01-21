class_name StaticBuoyantPost
extends BaseStaticBuoyant

export var required_items_amount := 3
onready var _button_prompt := $ButtonPrompt

var required_items := []


func _ready() -> void:
	required_items = _shuffle_items()
	pass


func remove_item_from_required(item) -> void:
	required_items.erase(item)
	pass

func toggle_button_prompt(toggle: bool) -> void:
	if _button_prompt:
		_button_prompt.visible = toggle
	pass


func _shuffle_items() -> Array:
	randomize()
	var items = []
	for i in range(required_items_amount):
		var type = ItemData.ITEM_TYPES.UNKNOWN
		while type == ItemData.ITEM_TYPES.UNKNOWN:
			type = ItemData.ITEM_TYPES.values()[randi() % ItemData.ITEM_TYPES.size()]
		items.append(ItemData.get_item_info_for_type(type))
	return items
