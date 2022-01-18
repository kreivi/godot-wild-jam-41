class_name DrifterSpawner
extends Node

export(Array, PackedScene) var drifting_items
export var item_container: NodePath


onready var _spawn_path_follow = $SpawnPath/SpawnPathFollow

var _item_container: Node = null


func _ready() -> void:
	_item_container = get_node(item_container)
	pass

## Spawn a drifter item.
func spawn_drifter() -> void:
	var drifter_i: int = randi() % drifting_items.size()
	var drifter = (drifting_items[drifter_i] as PackedScene).instance()
	_item_container.add_child(drifter)
	(drifter as Node2D).global_position = _spawn_path_follow.global_position
	(drifter as Node2D).rotation = _spawn_path_follow.rotation + PI / 2
	pass


## Kill bodies that leave the kill zone.
func _on_KillZone_body_exited(body: Node) -> void:
	if body.is_in_group("drifting"):
		Logger.trace(str("Killing drifter '" + body.name + "' as it's out of area"))
		body.queue_free()
	pass # Replace with function body.


## Timer callback. Spawns a drifter.
func _on_SpawnTimer_timeout() -> void:
	_spawn_path_follow.unit_offset = randf()
	spawn_drifter()
	pass # Replace with function body.
