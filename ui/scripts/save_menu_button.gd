class_name SaveMenuButton extends MenuButton

signal save_pressed
signal load_pressed
signal delete_pressed

@export var autosave_setting: BoolVariable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_popup().id_pressed.connect(_on_popup_menu_id_pressed)
	autosave_setting.changed.connect(_on_autosave_setting_changed)
	get_popup().set_item_checked(4, autosave_setting.value)


func _on_popup_menu_id_pressed(id: int) -> void:
	match id:
		0:
			save_pressed.emit()
		1:
			load_pressed.emit()
		2:
			delete_pressed.emit()
		4:
			autosave_setting.value = not autosave_setting.value


func _on_autosave_setting_changed() -> void:
	get_popup().set_item_checked(4, autosave_setting.value)
