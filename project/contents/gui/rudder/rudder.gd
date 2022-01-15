class_name HUDRudde
extends TextureRect

func _ready() -> void:
	var err = Signals.connect("rudder_turned", self, "_on_rudder_turned")
	if err != OK:
		Logger.warn("HUDRunner failed to connect signal: 'rudder_turned': " + str(err))
	pass

func _on_rudder_turned(new_value: float) -> void:
	Logger.debug("rudder turned: " + str(new_value))
	pass
