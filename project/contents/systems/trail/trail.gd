## https://github.com/RPicster/Godot-Advanced-Trails-Examples/blob/main/src/Scripts/smoketrail.gd
class_name Trail
extends Line2D

export var limited_lifetime := false
export var min_spawn_distance := 5.0
export var tick_speed := 0.25
export var wildness := 3.0


onready var _tween := $Decay

var _lifetime := [1.2, 1.6]
var _point_ages := [0.0]
var _tick := 0.0
var _wild_speed := 0.1
var _stopped := false

func _ready() -> void:
	set_as_toplevel(true)
	clear_points()
	if limited_lifetime:
		stop()
	pass

func _process(delta: float) -> void:
	if _tick > tick_speed:
		_tick = 0.0
		for p in range(get_point_count()):
			_point_ages[p] += 5*delta
			var rand_vector := Vector2(rand_range(-_wild_speed, _wild_speed), rand_range(-_wild_speed, _wild_speed))
			points[p] += rand_vector * wildness * _point_ages[p]
	else:
		_tick += delta
	pass


func stop() -> void:
	_stopped = true
	_tween.interpolate_property(self, "modulate:a", 1.0, 0.0, rand_range(_lifetime[0], _lifetime[1]), Tween.TRANS_CIRC, Tween.EASE_OUT)
	_tween.start()
	pass

func _add_point(point_pos: Vector2, at_pos := -1) -> void:
	if get_point_count() > 0 and point_pos.distance_to(points[get_point_count() - 1] ) < min_spawn_distance:
		return
	_point_ages.append(0.0)
	add_point(point_pos, at_pos)
	pass

func _on_Decay_tween_all_completed() -> void:
	queue_free()
	pass
