class_name SeaWorld
extends Node2D

const WIND_HOWL_SFX := [
	preload("res://contents/entities/world/winds_howling_01.wav"),
	preload("res://contents/entities/world/winds_howling_02.wav"),
	preload("res://contents/entities/world/winds_howling_03.wav"),
	preload("res://contents/entities/world/winds_howling_04.wav"),
]

var min_howl_interval := 7.0
var max_howl_interval := 21.0

onready var _wind_howl_timer := $WindHowlTimer
onready var _wind_howling := $WindHowlingSFX

func _ready() -> void:
	randomize()
	pass


func play_wind_howl_sfx() -> void:
	if not _wind_howling.is_playing():
		_wind_howling.stream = WIND_HOWL_SFX[randi() % WIND_HOWL_SFX.size()]
		_wind_howling.play()

func _on_WindHowlTimer_timeout() -> void:
	play_wind_howl_sfx()
	_wind_howl_timer.wait_time = rand_range(min_howl_interval, max_howl_interval)
	pass
