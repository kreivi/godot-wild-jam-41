class_name InventoryGUI
extends VBoxContainer

export var title := "Inventory"

onready var _title := $Label
onready var _item_list := $ItemList

func _ready() -> void:
	if _title:
		_title.text = title.to_upper()
	pass


func get_texture(path: String) -> ImageTexture:
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(path)
	texture.create_from_image(image)
	return texture

func set_items(items: Array) -> void:
	_item_list.clear()
	for item in items:
		_item_list.add_item(item["name"], get_texture(item["img"]))
	pass


func get_selected_items() -> PoolIntArray:
	return _item_list.get_selected_items()


func remove_with_index(index: int) -> void:
	_item_list.remove_item(index)
	pass


func remove_with_name(name: String) -> void:
	for i in range (_item_list.get_item_count()):
		if _item_list.get_item_text(i) == name:
			remove_with_index(i)
			return
	pass
