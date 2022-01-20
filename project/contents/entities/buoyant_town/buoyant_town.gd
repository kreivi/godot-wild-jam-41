class_name BuoyantTown
extends BaseStaticBuoyant

onready var _button_prompt := $ButtonPrompt

func toggle_button_prompt(toggle: bool) -> void:
	if _button_prompt:
		_button_prompt.visible = toggle
	pass

