extends Control

const SAIL_LOWER_SFX = preload("res://contents/entities/base_vessel/hoist_sail_01.wav")
const SAIL_HOIST_SFX = preload("res://contents/entities/base_vessel/lower_sail_01.wav")

onready var _sfx_player := $SailSFXPlayer

func _ready() -> void:
	var err := Signals.connect("sail_adjusted", self, "_on_sail_adjusted")
	if err != OK:
		Logger.warn("HUDSail failed to connect signal: 'sail_adjusted': " + str(err))
	pass

func _on_sail_adjusted(new_value: float, previous_value: float) -> void:
	if not _sfx_player.is_playing():
		if new_value > previous_value:
			_sfx_player.stream = SAIL_HOIST_SFX
		else:
			_sfx_player.stream = SAIL_LOWER_SFX
		_sfx_player.play()
	pass
