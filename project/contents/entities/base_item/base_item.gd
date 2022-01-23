class_name BaseItem
extends BaseBuoyant

const PICKUP_SFX := [
	preload("res://contents/entities/base_item/pickup_01.wav"),
	preload("res://contents/entities/base_item/pickup_02.wav"),
	preload("res://contents/entities/base_item/pickup_01.wav")
]
export var type: int = ItemData.ITEM_TYPES.UNKNOWN

onready var _button_prompt := $PickupPrompt
onready var _pickup_sound := $PickupSound

func _physics_process(_delta: float) -> void:
	if _button_prompt:
		_button_prompt.global_rotation_degrees = 0
	pass


func toggle_button_prompt(toggle: bool) -> void:
	if _button_prompt:
		_button_prompt.visible = toggle
	pass


func play_pickup_sfx() -> void:
	if not _pickup_sound.is_playing():
		_pickup_sound.stream = PICKUP_SFX[randi() % PICKUP_SFX.size()]
		_pickup_sound.play()
	pass


func _on_PickupSound_finished() -> void:
	# Destroy after sfx has played
	queue_free()
	pass
