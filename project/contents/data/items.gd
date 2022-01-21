class_name ItemData
extends Node

enum ITEM_TYPES { UNKNOWN, BARREL, WOOD, PLASTIC}

static func get_item_info_for_type(type: int) -> Dictionary:
	match type:
		ITEM_TYPES.BARREL:
			return {
				"type": ITEM_TYPES.BARREL,
				"name": "Metal",
				"img": "res://contents/entities/item_barrel/t_barrel_a.png"
			}
		ITEM_TYPES.WOOD:
			return {
				"type": ITEM_TYPES.WOOD,
				"name": "Wood",
				"img": "res://contents/entities/item_wood/t_log_a.png",
			}
		ITEM_TYPES.PLASTIC:
			return {
					"type": ITEM_TYPES.PLASTIC,
					"name": "Plastic",
					"img": "",
			}
	return {
		"type": ITEM_TYPES.UNKNOWN,
		"name": "Unknown",
		"img": ""
	}
