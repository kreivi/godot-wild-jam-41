extends Node



func _on_SFXToggle_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(0, button_pressed)
	pass
