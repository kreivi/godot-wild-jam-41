class_name TradeWindowGUI
extends CenterContainer

onready var _player_inv := $VBoxContainer/HBoxContainer/PlayerInventory
onready var _post_inv := $VBoxContainer/HBoxContainer/PostInventory

var _vessel: BaseVessel
var _post: StaticBuoyantPost

func _ready() -> void:
	Signals.connect("on_trade_initiated", self, "_on_trade_initiated")
	pass


func _on_trade_initiated(vessel: BaseVessel, post: StaticBuoyantPost) -> void:
	_vessel = vessel
	_post = post
	visible = true
	_player_inv.set_items(_vessel.inventory)
	_post_inv.set_items(_post.required_items)
	pass


func _on_CloseButton_pressed() -> void:
	visible = false
	_vessel = null
	_post = null
	pass


func _on_GiveButton_pressed() -> void:
	var item_indexes: PoolIntArray = _player_inv.get_selected_items()
	if item_indexes.size() > 0:
		for i in item_indexes:
			var v_item = _vessel.inventory[i]
			for p_item in _post.required_items:
				if v_item.type == p_item.type:
					_vessel.remove_item_from_inventory(v_item)
					_post.remove_item_from_required(p_item)
					_player_inv.remove_with_index(i)
					_post_inv.remove_with_name(p_item["name"])
					break
	pass
