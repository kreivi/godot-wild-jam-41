class_name StaticBuoyantPost
extends BaseStaticBuoyant

export var required_items_amount := 3
onready var _button_prompt := $ButtonPrompt

var required_items := []


onready var _sink_tween := $SinkTween
onready var _proximity_sfx := $ProximitySFX

func _ready() -> void:
	required_items = _shuffle_items()
	pass


func remove_item_from_required(item) -> void:
	required_items.erase(item)
	if required_items.size() <= 0:
		toggle_button_prompt(false)
		sink_to_ocean()
		Signals.emit_signal("on_trade_close")
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


func sink_to_ocean() -> void:
	_sink_tween.interpolate_property(self, "scale:x", 1.0, 0.0, 5.0, Tween.TRANS_CIRC, Tween.EASE_IN)
	_sink_tween.interpolate_property(self, "scale:y", 1.0, 0.0, 5.0, Tween.TRANS_CIRC, Tween.EASE_IN)
	_sink_tween.start()
	pass


func _on_SinkTween_tween_all_completed() -> void:
	queue_free()
	pass


func _on_ProximitySFX_finished() -> void:
	_proximity_sfx.play()
	pass


func _on_SinkTween_tween_step(object: Object, key: NodePath, elapsed: float, value: Object) -> void:
	_proximity_sfx.pitch_scale = 1.0+sinh(elapsed)
	_proximity_sfx.volume_db = -(elapsed * 4)
	pass
