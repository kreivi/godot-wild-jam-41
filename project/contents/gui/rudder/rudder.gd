## HUD element for rudder
class_name HUDRudder
extends TextureRect

## How much will the rudder rotate
export var rudder_max_rotate_angle := 360

## Connect into signal to update the HUD element accordingly.
func _ready() -> void:
	var err := Signals.connect("rudder_turned", self, "_on_rudder_turned")
	if err != OK:
		Logger.warn("HUDRudder failed to connect signal: 'rudder_turned': " + str(err))
	pass


## Callback for rudder signal
func _on_rudder_turned(new_value: float) -> void:
	rect_rotation = new_value * rudder_max_rotate_angle
	pass
