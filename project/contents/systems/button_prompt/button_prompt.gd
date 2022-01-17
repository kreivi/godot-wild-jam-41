class_name ButtonPrompt
extends AnimatedSprite

export var action_name := "unknown"

onready var key_label := $Key

func _ready() -> void:
	var actions := InputMap.get_action_list(action_name)
	if actions.size() > 0:
		key_label.text = actions[0].as_text()
	pass
