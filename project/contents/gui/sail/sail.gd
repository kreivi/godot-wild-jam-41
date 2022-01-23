## HUD element for sail.
class_name HUDSail
extends TextureRect

var sail_height = rect_size.y

func _ready() -> void:
	var err := Signals.connect("sail_adjusted", self, "_on_sail_adjusted")
	if err != OK:
		Logger.warn("HUDSail failed to connect signal: 'sail_adjusted': " + str(err))
	pass


func _on_sail_adjusted(new_value: float, _previous_value: float) -> void:
	rect_position.y = 1080 - new_value * sail_height
	pass
