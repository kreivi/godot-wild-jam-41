## HUD element for rudder
class_name HUDRudder
extends TextureRect

const RUDDER_TURN_SFX := [
	preload("res://contents/entities/base_vessel/rudder_01.wav"),
	preload("res://contents/entities/base_vessel/rudder_02.wav"),
	preload("res://contents/entities/base_vessel/rudder_03.wav"),
]

## How much will the rudder rotate
export var rudder_max_rotate_angle := 360

onready var _turn_sfx := $TurnSFXPlayer

## Connect into signal to update the HUD element accordingly.
func _ready() -> void:
	var err := Signals.connect("rudder_turned", self, "_on_rudder_turned")
	if err != OK:
		Logger.warn("HUDRudder failed to connect signal: 'rudder_turned': " + str(err))
	pass


## Callback for rudder signal
func _on_rudder_turned(new_value: float, _previous_value: float) -> void:
	rect_rotation = new_value * rudder_max_rotate_angle
	if not _turn_sfx.is_playing():
		_turn_sfx.stream = RUDDER_TURN_SFX[randi() % RUDDER_TURN_SFX.size()]
		_turn_sfx.play()
	pass
