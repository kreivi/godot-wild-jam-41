class_name DriftingWood
extends DriftingItem

## Returns item information
func get_item_info() -> Dictionary:
	return {
		"type": ITEM_TYPES.WOOD,
		"img": "res://contents/entities/item_wood/t_log_a.png",
	}
