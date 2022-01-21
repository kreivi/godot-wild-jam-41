class_name DriftingBarrel
extends DriftingItem

## Returns item information
func get_item_info() -> Dictionary:
	return {
		"type": ITEM_TYPES.BARREL,
		"img": "res://contents/entities/item_barrel/t_barrel_a.png",
	}
