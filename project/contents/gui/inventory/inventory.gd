class_name InventoryGUI
extends VBoxContainer

export var title := "Inventory"

var items := []

onready var _title := $Label

func _ready() -> void:
	if _title:
		_title.text = title.to_upper()
	pass

func _add_item(item: BaseItem) -> bool:
	if not items.find(item):
		items.append(item)
		return true
	return false
